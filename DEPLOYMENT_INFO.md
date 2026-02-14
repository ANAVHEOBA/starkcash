# GhostProtocol Deployment Information

## Network
**Starknet Sepolia Testnet**

## Deployed Contracts

### GhostPool Contract
- **Contract Address**: `0x07173242a9f07433cda2d2b1cec3cb7079305228617b2e4d306e4b9d21cf3a89`
- **Class Hash**: `0x05df74e58250eec5407f5efdf1ee556edf765fbb1abfd200847a079ebfb84c49`
- **Deployer Account**: `0x008383594d2af4e6a196d486a0cfecc4464de4d85bfdc37167bd31de03203448`
- **Deployment Transaction**: `0x024bd4308e0c0b28dff55b9b71b3ffe1efdbfb362438ade81ade65f124ef70df`

### Configuration
- **Token Address (ETH)**: `0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7`
- **Denomination**: `1 ETH` (1000000000000000000 wei)
- **Merkle Tree Depth**: 20 levels (supports 1,048,576 deposits)

## Contract Interface

### Deposit Function
```cairo
fn deposit(ref self: ContractState, commitment: u256)
```
- **Parameters**:
  - `commitment`: Poseidon hash of (secret, nullifier)
- **Requirements**:
  - User must approve GhostPool contract to spend denomination amount
  - User must have sufficient ETH balance

### Withdraw Function
```cairo
fn withdraw(
    ref self: ContractState,
    proof: Groth16Proof,
    root: u256,
    nullifier_hash: u256,
    recipient: ContractAddress,
    relayer: ContractAddress,
    fee: u256,
    refund: u256
)
```
- **Parameters**:
  - `proof`: Groth16 ZK proof (a, b, c points)
  - `root`: Merkle tree root
  - `nullifier_hash`: Hash of nullifier to prevent double-spending
  - `recipient`: Address to receive funds
  - `relayer`: Address of relayer (can be zero)
  - `fee`: Relayer fee amount
  - `refund`: Refund amount (usually 0)

### Proof Structure
```cairo
struct Groth16Proof {
    a: G1Point,
    b: G2Point,
    c: G1Point,
}

struct G1Point {
    x: u256,
    y: u256,
}

struct G2Point {
    x0: u256,
    x1: u256,
    y0: u256,
    y1: u256,
}
```

## Frontend Integration Guide

### 1. Connect to Starknet
```typescript
import { Provider, Contract } from 'starknet';

const provider = new Provider({
  sequencer: {
    network: 'sepolia-testnet'
  }
});

const contractAddress = '0x07173242a9f07433cda2d2b1cec3cb7079305228617b2e4d306e4b9d21cf3a89';
```

### 2. Deposit Flow
```typescript
// 1. Generate secret and nullifier (random 31-byte values)
const secret = generateRandomField();
const nullifier = generateRandomField();

// 2. Compute commitment = poseidon(secret, nullifier)
const commitment = poseidonHash([secret, nullifier]);

// 3. Approve ETH spending
await ethContract.approve(contractAddress, denomination);

// 4. Call deposit
await ghostPoolContract.deposit(commitment);
```

### 3. Withdraw Flow
```typescript
// 1. Get Merkle proof for your commitment
const merkleProof = await getMerkleProof(commitment);

// 2. Generate ZK proof using Circom + Rapidsnark
const zkProof = await generateZKProof({
  secret,
  nullifier,
  recipient,
  relayer,
  fee,
  refund,
  merkleProof
});

// 3. Call withdraw
await ghostPoolContract.withdraw(
  zkProof,
  merkleRoot,
  nullifierHash,
  recipient,
  relayer,
  fee,
  refund
);
```

## RPC Endpoints

### Alchemy (Recommended)
```
https://starknet-sepolia.g.alchemy.com/v2/14u0qd7a13nbJiytRrAV8
```

### Public Endpoints
- Blast API: `https://starknet-sepolia.public.blastapi.io`
- Infura: `https://starknet-sepolia.infura.io/v3/<YOUR_KEY>`

## Block Explorer
View contract on Starkscan:
```
https://sepolia.starkscan.co/contract/0x07173242a9f07433cda2d2b1cec3cb7079305228617b2e4d306e4b9d21cf3a89
```

## Testing

### Get Testnet ETH
1. Visit: https://faucet.starknet.io/
2. Enter your wallet address
3. Receive 800 STRK tokens

### Test Deposit
```bash
# Using starkli
starkli invoke \
  0x07173242a9f07433cda2d2b1cec3cb7079305228617b2e4d306e4b9d21cf3a89 \
  deposit \
  u256:YOUR_COMMITMENT \
  --account ~/.starkli-wallets/deployer/account.json \
  --keystore ~/.starkli-wallets/deployer/keystore.json \
  --rpc https://starknet-sepolia.g.alchemy.com/v2/14u0qd7a13nbJiytRrAV8
```

## ABI Files
Contract ABI is available at:
```
contracts/target/dev/starkcash_GhostPool.contract_class.json
```

## Important Notes

### ⚠️ Known Limitations
1. **Poseidon Hash Compatibility**: The contract uses Starknet Poseidon (252-bit), while Circom uses BN254 Poseidon (254-bit). For production, implement BN254 Poseidon in Cairo (see `ISSUE_4_FIX_GUIDE.md`).

2. **ZK Verifier**: Currently uses a fallback verifier for development. For production, deploy the Garaga Groth16 verifier and update `GROTH16_VERIFIER_CLASS_HASH` in `groth16_verifier_external.cairo`.

3. **Testnet Only**: This deployment is for testing purposes only. Do not use with real funds.

### 🔐 Security Considerations
- Always verify Merkle proofs before generating ZK proofs
- Store secrets securely (never expose them)
- Validate all inputs on the frontend
- Use HTTPS for all RPC connections
- Implement rate limiting for proof generation

## Support
- Documentation: See `README.md` and `ZK_PROOF_FLOW.md`
- Issues: Check `ISSUES_STATUS.md` for known issues
- Architecture: See `INTEGRATION_MAP.md`

## Next Steps for Production
1. Fix Poseidon compatibility (see `ISSUE_4_FIX_GUIDE.md`)
2. Deploy Garaga Groth16 verifier
3. Update verifier class hash in contract
4. Perform security audit
5. Deploy to mainnet

---
**Deployment Date**: February 14, 2026
**Network**: Starknet Sepolia Testnet
**Status**: ✅ Active
