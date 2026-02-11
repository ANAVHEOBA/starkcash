# Tornado Cash Features Analysis

> **Note**: This document is for educational/research purposes to understand privacy protocol patterns for the GhostProtocol hackathon project.

## Overview
Tornado Cash was a decentralized, non-custodial privacy solution using zero-knowledge proofs (ZK-SNARKs) to break the on-chain link between source and destination addresses.

---

## Core Privacy Features

### 1. ZK-SNARK Based Privacy
- **Technology**: zk-SNARKs (Groth16 proving system)
- **What it hides**: Breaks link between deposit and withdrawal addresses
- **Proof generation**: Client-side in browser, no trusted server
- **Verification**: On-chain smart contract verification

### 2. Commitment Scheme
- **Pedersen commitments** for deposit notes
- **Merkle tree** structure (height 20 = 1M capacity)
- **Nullifier hashes** prevent double-spending
- Each deposit creates unique commitment stored in Merkle tree

### 3. Denomination Pools
Fixed amounts to prevent amount-based correlation:
- ETH: 0.1, 1, 10, 100 ETH
- DAI: 100, 1000, 10000, 100000 DAI
- USDC: 100, 1000, 10000, 100000 USDC
- WBTC: 0.1, 1, 10, 100 WBTC

### 4. Withdrawal Mechanisms

#### Standard Withdrawal
- User provides ZK proof they own a commitment in the tree
- Nullifier prevents reuse
- Withdraw to any address (different from deposit address)

#### Relayer Support
- Third-party pays gas fees
- Prevents gas correlation attacks
- Relayer fee: 0.05% - 0.5%
- Relayer cannot steal funds (proof binds to recipient)

### 5. Anonymity Set
- **Metric**: Number of deposits in a pool
- **Privacy guarantee**: k-anonymity where k = pool size
- **Trade-off**: Larger pools = better privacy, but slower withdrawals

---

## Technical Architecture

### Smart Contract Structure

```
TornadoCash.sol
├── deposit(_commitment)
├── withdraw(_proof, _root, _nullifierHash, _recipient, _relayer, _fee, _refund)
├── isSpent(_nullifierHash) → bool
└── verifier() → Verifier contract
```

### Key Components

#### 1. Merkle Tree with MiMC Hash
- **Hash function**: MiMC (optimized for zk-SNARKs)
- **Tree height**: 20 levels
- **Max capacity**: 2^20 = 1,048,576 deposits
- **Insertion cost**: ~200k gas

#### 2. Nullifier System
```
nullifier = hash(secret, nullifier_seed)
commitment = hash(secret)
```
- Secret: Random 32-byte value (the "note")
- Nullifier: Unique per commitment, prevents double withdrawal

#### 3. Circuits

**Deposit Circuit** (implicit):
- Generate commitment from secret
- No proof required for deposit

**Withdrawal Circuit**:
```circom
public inputs:
  - root (Merkle root)
  - nullifierHash
  - recipient
  - relayer
  - fee
  - refund

private inputs:
  - secret
  - nullifier
  - pathElements[20]
  - pathIndices[20]

constraints:
  1. commitment == hash(secret)
  2. nullifierHash == hash(nullifier)
  3. MerkleProof(root, commitment, pathElements, pathIndices)
  4. nullifier == hash(secret, nullifier_seed)
```

### 4. Trusted Setup
- **Ceremony**: Multi-party computation (MPC)
- **Participants**: 1114 participants
- **Security**: If ONE participant was honest, setup is secure

---

## Security Features

### 1. Client-Side Note Generation
- Private key never leaves browser
- Note format: `tornado-<currency>-<amount>-<network>-0x<commitment>`
- BIP39-style mnemonic backup option

### 2. RPC Protection
- No IP logging by contracts
- Users can use their own RPC
- No centralized server

### 3. Front-Running Protection
- Commit-reveal pattern not needed (ZK proof is atomic)
- Withdrawal transaction includes all data in single tx

### 4. Amount Privacy
- Fixed denominations prevent value correlation
- No metadata leakage about transaction size

---

## User Experience Features

### 1. Note Management
- Copy-to-clipboard with one click
- QR code generation for mobile
- Browser localStorage backup (optional)
- Note decryption from backup file

### 2. Compliance Tools
- **Optional**: Generate compliance reports
- Prove ownership without revealing which deposit
- Export history for tax purposes

### 3. Multi-Chain Support
- Ethereum mainnet
- BSC (Binance Smart Chain)
- Polygon
- Avalanche
- Arbitrum
- Optimism
- Gnosis Chain

### 4. Token Support
- Native ETH
- Major ERC-20s (DAI, USDC, USDT, WBTC)
- Custom token addition via governance

---

## Advanced Features

### 1. Anonymity Mining (TORN Token)
- Reward users for depositing longer
- Incentivize liquidity in pools
- Anonymous claiming via ZK proofs

### 2. Governance
- TORN token holders vote on:
  - New token additions
  - Fee changes
  - Protocol upgrades
- Anonymous voting via ZK

### 3. Nova (Layer 2 Scaling)
- Lower gas costs for deposits/withdrawals
- Same privacy guarantees
- Batch processing

### 4. Multi-Deposit Aggregation
- Deposit to multiple pools in one transaction
- Save on gas costs
- Increase anonymity set participation

---

## Attack Vectors & Mitigations

### 1. Timing Analysis
- **Attack**: Link deposits/withdrawals by timestamp correlation
- **Mitigation**: Wait for multiple deposits before withdrawing

### 2. Amount Correlation
- **Attack**: Link by unique amounts
- **Mitigation**: Fixed denominations only

### 3. Gas Price Correlation
- **Attack**: Same wallet uses similar gas prices
- **Mitigation**: Use relayers (different gas price patterns)

### 4. Deposit-Withdrawal Graph Analysis
- **Attack**: Heuristic linking based on timing + amounts
- **Mitigation**: Wait for anonymity set to grow

### 5. Dust Attacks
- **Attack**: Attacker deposits dust to track specific notes
- **Mitigation**: Minimum deposit amounts, large anonymity sets

---

## Gas Costs (Historical)

| Operation | Gas Cost | Notes |
|-----------|----------|-------|
| Deposit | ~200,000 | Merkle tree insertion |
| Withdraw (self) | ~300,000 | Proof verification + transfer |
| Withdraw (relayer) | ~350,000 | Plus relayer payment logic |
| ERC-20 Deposit | ~250,000 | Token approval + deposit |

---

## What GhostProtocol Can Learn

### Patterns to Adopt:
1. **Merkle tree commitments** - Proven scalable pattern
2. **Nullifier system** - Prevents double-spending elegantly
3. **Fixed denominations** - Simple but effective privacy
4. **Client-side proving** - No trusted server needed
5. **Relayer support** - Critical for gas abstraction

### Improvements for Bitcoin Track:
1. **Account Abstraction** - Better UX than EOAs
2. **Faster finality** - Starknet vs Ethereum block times
3. **Lower costs** - L2 scaling benefits
4. **Cross-chain BTC** - tBTC or similar bridging

### Unique GhostProtocol Features to Add:
1. **Link/QR payments** - Tornado didn't have this
2. **Session keys** - AA for gasless UX
3. **Stealth addresses** - Extra layer for recipients
4. **Time-locked withdrawals** - Optional delayed release
5. **Social recovery** - Lose note = lose funds in Tornado

---

## Resources

- Original contracts: https://github.com/tornadocash/tornado-core
- Circuit code: https://github.com/tornadocash/tornado-circuits
- Whitepaper: https://tornado.cash/audits/TornadoCash_whitepaper.pdf

---

*Document created for GhostProtocol Hackathon Research*
*Date: February 2026*
