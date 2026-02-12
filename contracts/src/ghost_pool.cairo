use starknet::ContractAddress;
use core::circuit::u384;

#[starknet::interface]
pub trait IERC20<TContractState> {
    fn transfer(ref self: TContractState, recipient: ContractAddress, amount: u256) -> bool;
    fn transfer_from(
        ref self: TContractState,
        sender: ContractAddress,
        recipient: ContractAddress,
        amount: u256
    ) -> bool;
}

#[derive(Copy, Drop, Serde, Debug, PartialEq)]
pub struct G1Point {
    pub x: u384,
    pub y: u384,
}

#[derive(Copy, Drop, Serde, Debug, PartialEq)]
pub struct G2Point {
    pub x0: u384,
    pub x1: u384,
    pub y0: u384,
    pub y1: u384,
}

#[derive(Copy, Drop, Serde, Debug, PartialEq)]
pub struct Groth16ProofRaw {
    pub a: G1Point,
    pub b: G2Point,
    pub c: G1Point,
}

#[starknet::interface]
pub trait IGhostPool<TContractState> {
    fn deposit(ref self: TContractState, commitment: u256);
    fn withdraw(
        ref self: TContractState,
        proof: Groth16ProofRaw,
        root: u256,
        nullifier_hash: u256,
        recipient: ContractAddress,
        relayer: ContractAddress,
        fee: u256,
        refund: u256
    );
}

#[starknet::contract]
mod GhostPool {
    use super::{IERC20Dispatcher, IERC20DispatcherTrait, IGhostPool, Groth16ProofRaw, G1Point, G2Point};
    use starkcash::merkle_tree::MerkleTreeComponent;
    use starknet::{ContractAddress, get_caller_address, get_contract_address};
    use starknet::storage::{Map, StoragePointerReadAccess, StoragePointerWriteAccess, StoragePathEntry};

    component!(path: MerkleTreeComponent, storage: merkle_tree, event: MerkleTreeEvent);

    impl MerkleTreeInternalImpl = MerkleTreeComponent::InternalImpl<ContractState>;

    #[storage]
    struct Storage {
        token: IERC20Dispatcher,
        denomination: u256,
        nullifiers: Map<u256, bool>,
        #[substorage(v0)]
        merkle_tree: MerkleTreeComponent::Storage,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        Deposit: Deposit,
        Withdraw: Withdraw,
        MerkleTreeEvent: MerkleTreeComponent::Event,
    }

    #[derive(Drop, starknet::Event)]
    struct Deposit {
        commitment: u256,
        leaf_index: u32,
        timestamp: u64,
    }

    #[derive(Drop, starknet::Event)]
    struct Withdraw {
        to: ContractAddress,
        nullifier_hash: u256,
        relayer: ContractAddress,
        fee: u256,
    }

    #[constructor]
    fn constructor(ref self: ContractState, token_address: ContractAddress, denomination: u256) {
        self.token.write(IERC20Dispatcher { contract_address: token_address });
        self.denomination.write(denomination);
        self.merkle_tree.initialize();
    }

    #[abi(embed_v0)]
    impl GhostPoolImpl of IGhostPool<ContractState> {
        fn deposit(ref self: ContractState, commitment: u256) {
            let caller = get_caller_address();
            let amount = self.denomination.read();
            
            // Transfer tokens from user to contract
            self.token.read().transfer_from(caller, get_contract_address(), amount);

            // Insert commitment into Merkle tree
            let _root = self.merkle_tree.insert(commitment);
            
            let leaf_index = self.merkle_tree.next_index.read() - 1;
            
            self.emit(Deposit { 
                commitment, 
                leaf_index, 
                timestamp: starknet::get_block_timestamp() 
            });
        }

        fn withdraw(
            ref self: ContractState,
            proof: Groth16ProofRaw,
            root: u256,
            nullifier_hash: u256,
            recipient: ContractAddress,
            relayer: ContractAddress,
            fee: u256,
            refund: u256
        ) {
            // 1. Check if nullifier has been used
            assert(!self.nullifiers.entry(nullifier_hash).read(), 'Nullifier already spent');

            // 2. Check if root is known
            assert(self.merkle_tree.is_known_root(root), 'Unknown Merkle root');

            // 3. Verify ZK Proof (Placeholder for now)
            self.verify_zk_proof(proof, root, nullifier_hash, recipient, relayer, fee, refund);

            // 4. Mark nullifier as spent
            self.nullifiers.entry(nullifier_hash).write(true);

            // 5. Transfer funds
            let amount = self.denomination.read();
            assert(amount > fee, 'Fee exceeds denomination');
            
            let withdraw_amount = amount - fee;
            self.token.read().transfer(recipient, withdraw_amount);
            
            if fee > 0 {
                self.token.read().transfer(relayer, fee);
            }

            self.emit(Withdraw { to: recipient, nullifier_hash, relayer, fee });
        }
    }

    #[generate_trait]
    impl InternalFunctions of InternalTrait {
        fn verify_zk_proof(
            self: @ContractState,
            proof: Groth16ProofRaw,
            root: u256,
            nullifier_hash: u256,
            recipient: ContractAddress,
            relayer: ContractAddress,
            fee: u256,
            refund: u256
        ) {
            // In a real hackathon submission, we integrate Garaga call here.
            // Since we're in a limited env, we'll keep the logic modular.
        }
    }
}
