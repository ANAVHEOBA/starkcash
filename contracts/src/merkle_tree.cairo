use starkcash::poseidon::poseidon_hash_2;

const LEVELS: usize = 20;
const ROOT_HISTORY_SIZE: usize = 30;

// BN254 Prime for manual reduction if needed, 
// though we'll use u256 for storage.
const BN254_PRIME: u256 = 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001;

/// Get the zero value for a specific level.
/// Precomputed using Poseidon on BN254.
fn get_zero(level: usize) -> u256 {
    // Initial zero value (Keccak256("tornado"))
    let mut current: u256 = 0x2fe54c60d3acabf3343a35b6eba75fdc3c446483168233f2c5f74358a9e64e52;
    let mut i = 0;
    loop {
        if i >= level { break; }
        // Compute dynamically for now. 
        // We use a helper function that doesn't depend on ComponentState
        current = hash_u256_left_right(current, current);
        i += 1;
    };
    current
}

fn hash_u256_left_right(left: u256, right: u256) -> u256 {
    poseidon_hash_2(left, right)
}

#[starknet::component]
pub mod MerkleTreeComponent {
    use super::{LEVELS, ROOT_HISTORY_SIZE, get_zero, hash_u256_left_right};
    use starknet::storage::{Map, StoragePointerReadAccess, StoragePointerWriteAccess, StoragePathEntry};
    use core::hash::HashStateTrait;

    #[storage]
    pub struct Storage {
        pub next_index: u32,
        pub filled_subtrees: Map<u32, u256>,
        pub roots: Map<u32, u256>,
        pub current_root_index: u32,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event {
        LeafInserted: LeafInserted,
    }

    #[derive(Drop, starknet::Event)]
    pub struct LeafInserted {
        pub leaf: u256,
        pub index: u32,
        pub root: u256,
    }

    #[generate_trait]
    pub impl InternalImpl<TContractState, +HasComponent<TContractState>> of InternalTrait<TContractState> {
        fn initialize(ref self: ComponentState<TContractState>) {
            let mut i = 0;
            loop {
                if i >= LEVELS { break; }
                self.filled_subtrees.entry(i.try_into().unwrap()).write(get_zero(i));
                i += 1;
            };
            
            let empty_root = get_zero(LEVELS);
            self.roots.entry(0).write(empty_root);
        }

        fn insert(ref self: ComponentState<TContractState>, leaf: u256) -> u256 {
            let index = self.next_index.read();
            assert(index < 0x100000, 'Merkle tree is full');

            let mut current_hash = leaf;
            let mut i: u32 = 0;
            let mut curr_idx = index;

            loop {
                if i >= LEVELS.try_into().unwrap() { break; }

                if curr_idx % 2 == 0 {
                    self.filled_subtrees.entry(i).write(current_hash);
                    current_hash = hash_u256_left_right(current_hash, get_zero(i.try_into().unwrap()));
                } else {
                    let left = self.filled_subtrees.entry(i).read();
                    current_hash = hash_u256_left_right(left, current_hash);
                }

                curr_idx /= 2;
                i += 1;
            };

            let new_root_index = (self.current_root_index.read() + 1) % ROOT_HISTORY_SIZE.try_into().unwrap();
            self.roots.entry(new_root_index).write(current_hash);
            self.current_root_index.write(new_root_index);
            self.next_index.write(index + 1);

            self.emit(LeafInserted { leaf, index, root: current_hash });

            current_hash
        }

        fn is_known_root(self: @ComponentState<TContractState>, root: u256) -> bool {
            if root == 0 { return false; }
            let mut i: u32 = 0;
            let mut found = false;
            loop {
                if i >= ROOT_HISTORY_SIZE.try_into().unwrap() { break; }
                if self.roots.entry(i).read() == root {
                    found = true;
                    break;
                }
                i += 1;
            };
            found
        }

        fn get_root(self: @ComponentState<TContractState>) -> u256 {
            self.roots.entry(self.current_root_index.read()).read()
        }
    }
}
