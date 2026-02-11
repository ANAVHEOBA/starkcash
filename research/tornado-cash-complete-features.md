# Tornado Cash - Complete Feature List

> **Research Document**: Comprehensive analysis of Tornado Cash features for educational purposes  
> **Date**: February 2026  
> **Sources**: Official documentation, GitHub repos, whitepapers, and technical analyses

---

## Table of Contents
1. [Core Privacy Features](#1-core-privacy-features)
2. [Technical Architecture](#2-technical-architecture)
3. [User Experience Features](#3-user-experience-features)
4. [Economic Incentive Features](#4-economic-incentive-features)
5. [Governance Features](#5-governance-features)
6. [Compliance & Safety Features](#6-compliance--safety-features)
7. [Multi-Chain & Multi-Asset Support](#7-multi-chain--multi-asset-support)
8. [Tornado Cash Nova (L2) Features](#8-tornado-cash-nova-l2-features)
9. [Advanced Features](#9-advanced-features)
10. [Security Features](#10-security-features)

---

## 1. Core Privacy Features

### 1.1 ZK-SNARK Based Privacy Engine
- **Technology**: zk-SNARKs (Zero-Knowledge Succinct Non-Interactive Arguments of Knowledge)
- **Proving System**: Groth16 (most efficient proving system)
- **What it hides**: Completely breaks the on-chain link between deposit and withdrawal addresses
- **Proof Generation**: Client-side in browser - no trusted server required
- **Verification**: On-chain smart contract verification
- **Zero-Knowledge Property**: Verifier learns nothing except that the statement is true

### 1.2 Commitment Scheme
- **Commitment Type**: Pedersen hash commitments
- **Data Structure**: Incremental Merkle tree (height 20 = 1,048,576 max capacity)
- **Tree Operations**: 
  - O(log n) insertion
  - O(log n) membership proof
- **Nullifier System**: Prevents double-spending via unique nullifier hashes
- **Nullifier Generation**: `nullifier = hash(secret, nullifier_seed)`
- **Commitment Generation**: `commitment = hash(secret)`
- **Secret Format**: 32-byte random value (the "note")

### 1.3 Fixed Denomination Pools (Classic)
Prevents amount-based correlation attacks:

**ETH Pools:**
- 0.1 ETH
- 1 ETH
- 10 ETH
- 100 ETH

**DAI Pools:**
- 100 DAI
- 1,000 DAI
- 10,000 DAI
- 100,000 DAI

**USDC Pools:**
- 100 USDC
- 1,000 USDC
- 10,000 USDC
- 100,000 USDC

**USDT Pools:**
- 100 USDT
- 1,000 USDT
- 10,000 USDT
- 100,000 USDT

**WBTC Pools:**
- 0.1 WBTC
- 1 WBTC
- 10 WBTC
- 100 WBTC

### 1.4 Withdrawal Mechanisms

#### Standard Withdrawal
- User proves ownership of commitment in Merkle tree via ZK proof
- Provides nullifier hash to prevent double-spending
- Withdraw to any address (different from deposit address)
- No link between deposit and withdrawal visible on-chain

#### Relayer-Based Withdrawal
- Third-party relayer pays gas fees on behalf of user
- Relayer fee: 0.05% - 0.5% of withdrawal amount
- Relayer cannot steal funds (ZK proof cryptographically binds to recipient address)
- Solves "fee payment dilemma" (how to pay gas without linking to deposit address)
- Prevents gas price correlation attacks

### 1.5 Anonymity Set
- **Definition**: Number of deposits in a specific pool
- **Privacy Guarantee**: k-anonymity where k = number of deposits
- **Heuristic**: Larger pool size = stronger privacy
- **Recommendation**: Wait for minimum 5-10 deposits before withdrawing
- **Current anonymity sets**: Viewable on tornado.cash stats page

---

## 2. Technical Architecture

### 2.1 Smart Contract Structure

**Core Contracts:**
```
TornadoCash.sol (Pool Contract)
├── deposit(bytes32 _commitment)
├── withdraw(
│   bytes calldata _proof,
│   bytes32 _root,
│   bytes32 _nullifierHash,
│   address payable _recipient,
│   address payable _relayer,
│   uint256 _fee,
│   uint256 _refund
│ )
├── isSpent(bytes32 _nullifierHash) → bool
├── verifier() → IVerifier
└── denomination() → uint256

Verifier.sol (Proof Verification)
└── verifyProof(
    uint256[2] memory a,
    uint256[2][2] memory b,
    uint256[2] memory c,
    uint256[6] memory input
) → bool
```

**Tornado Proxy Contract:**
- Immutable core contract wrapper
- Enables additional features without modifying battle-tested core
- On-chain encrypted note backup functionality
- Queues deposits/withdrawals for Tornado Trees processing

### 2.2 Merkle Tree Implementation

**Tree Specifications:**
- **Hash Function**: MiMC (MMinimized Multiplicative Complexity) - optimized for ZK circuits
- **Tree Height**: 20 levels
- **Maximum Capacity**: 2^20 = 1,048,576 deposits
- **Insertion Gas Cost**: ~200,000 gas
- **Hash Operations**: O(log n) per insertion

**MerkleTreeWithHistory.sol:**
- Maintains history of last 30 roots
- Prevents front-running attacks on root updates
- Enables withdrawals even if tree is updated between deposit and withdraw

### 2.3 ZK Circuit Architecture

**Deposit Circuit (Implicit):**
- Generates commitment from secret
- No explicit proof required for deposit
- Commitment computed client-side: `commitment = PedersenHash(secret)`

**Withdrawal Circuit (withdraw.circom):**

```circom
template Withdraw(levels) {
    // Public inputs (visible on-chain)
    signal input root;              // Merkle root
    signal input nullifierHash;     // Prevents double spend
    signal input recipient;         // Withdrawal address
    signal input relayer;           // Optional relayer address
    signal input fee;               // Relayer fee
    signal input refund;            // Gas refund

    // Private inputs (hidden by ZK proof)
    signal input secret;            // Note secret
    signal input nullifier;         // Nullifier preimage
    signal input pathElements[levels];  // Merkle proof siblings
    signal input pathIndices[levels];   // Merkle proof path

    // Constraints
    component commitmentHasher = Pedersen(2);
    commitmentHasher.inputs[0] <== secret;
    commitmentHasher.inputs[1] <== 0;
    
    component nullifierHasher = Pedersen(2);
    nullifierHasher.inputs[0] <== secret;
    nullifierHasher.inputs[1] <== 1;
    nullifierHasher.out === nullifierHash;

    component tree = MerkleTreeChecker(levels);
    tree.leaf <== commitmentHasher.out;
    tree.root <== root;
    for (var i = 0; i < levels; i++) {
        tree.pathElements[i] <== pathElements[i];
        tree.pathIndices[i] <== pathIndices[i];
    }
}
```

**Circuit Constraints:**
- Commitment integrity check
- Nullifier hash computation
- Merkle proof verification
- Tree root validation

### 2.4 Trusted Setup

**Multi-Party Computation (MPC) Ceremony:**
- **Participants**: 1,114 participants
- **Security Model**: If ONE participant was honest and destroyed their toxic waste, the setup is secure
- **Verification**: Ceremony transcripts publicly available for verification
- **Toxic Waste**: Random values used in setup that must be destroyed

---

## 3. User Experience Features

### 3.1 Note Management System

**Note Format:**
```
tornado-<currency>-<amount>-<network>-0x<commitment_hex>
```

**Example:**
```
tornado-eth-0.1-1-0x8db49b7febf50f55b8476b91d80c0b58e479b94fa4ba565c7dcc550bc9d381f0f281587ae9081c168a62fa33b5a4ce39172d01a36d6e726bc632c4e57c09
```

**Note Features:**
- One-click copy-to-clipboard
- QR code generation for mobile transfers
- Browser localStorage backup (optional, user-controlled)
- Note decryption from encrypted backup file
- BIP39-style mnemonic backup option
- **CRITICAL**: Note = private key. Lose note = lose funds permanently

### 3.2 Web Interface

**UI Components:**
- Deposit interface with amount selection
- Withdrawal interface with proof generation
- Note input field (paste or scan QR)
- Recipient address input
- Relayer selection dropdown
- Transaction status tracking
- Anonymity set size display

**IPFS Deployment:**
- UI hosted on IPFS (decentralized storage)
- Multiple mirrors available
- Censorship-resistant access
- Users can run UI locally

### 3.3 Wallet Integration

**Supported Wallets:**
- MetaMask (primary)
- WalletConnect (mobile wallets)
- Coinbase Wallet
- Ledger (via MetaMask)
- Trezor (via MetaMask)

**Connection Features:**
- Automatic network switching
- Balance display
- Gas estimation
- Transaction confirmation flow

### 3.4 Privacy Best Practices Guide

**Built-in Recommendations:**
- Wait time recommendations between deposit/withdraw
- Minimum anonymity set size warnings
- IP protection suggestions (use VPN/Tor)
- Browser fingerprinting warnings
- Amount randomization tips

---

## 4. Economic Incentive Features

### 4.1 Anonymity Mining (TORN Rewards)

**Concept**: Reward users for keeping funds in pools longer

**Mechanism:**
- Users earn TORN tokens based on:
  - Amount deposited
  - Duration in pool
  - Pool size (larger pools = higher rewards)
- **APY**: Variable based on participation
- **Vesting**: Linear vesting over time
- **Claiming**: Anonymous claiming via ZK proofs

**Reward Formula:**
```
Rewards ∝ (Amount) × (Time in pool) × (Pool weight)
```

**Incentive Structure:**
- Encourages longer deposit periods
- Increases anonymity set size
- Aligns user behavior with privacy goals

### 4.2 Relayer Economics

**Relayer Requirements:**
- Minimum stake: 2,000 TORN tokens (locked)
- Must maintain sufficient TORN to pay back transaction fees
- Stake can be slashed for misbehavior

**Relayer Revenue:**
- Fee percentage: 0.05% - 0.5% (set by relayer)
- Users choose relayer based on fee/reputation
- Competition drives fees down

**Relayer Infrastructure:**
- Must run full Ethereum node
- Must maintain high availability
- Must handle proof generation requests

### 4.3 Gas Optimization

**Gas Costs (Historical Ethereum Mainnet):**

| Operation | Gas Cost | ~Cost (at 50 gwei) |
|-----------|----------|-------------------|
| ETH Deposit | ~200,000 | $25 |
| ETH Withdraw (self) | ~300,000 | $37 |
| ETH Withdraw (relayer) | ~350,000 | $44 |
| ERC-20 Deposit | ~250,000 | $31 |
| ERC-20 Withdraw | ~400,000 | $50 |

**Gas Optimization Techniques:**
- Merkle tree batch updates
- Efficient MiMC hashing
- Optimized storage layout
- Calldata compression

---

## 5. Governance Features

### 5.1 TORN Token

**Token Specifications:**
- **Type**: ERC-20
- **Total Supply**: 10,000,000 TORN (fixed, no minting)
- **Decimals**: 18

**Token Distribution:**
- 5% (500,000) - Airdrop to early ETH pool users (before block 11,400,000)
- 10% (1,000,000) - Anonymity mining for ETH pools (1 year linear vesting)
- 55% (5,500,000) - DAO Treasury (5 year linear vesting, 3 month cliff)
- 30% (3,000,000) - Founding developers & early supporters (3 year linear, 1 year cliff)

### 5.2 Governance Process

**Proposal Flow:**
1. **Forum Discussion**: Community discusses on Tornado Cash forum
2. **Proposal Creation**: Requires 1,000 TORN to submit
3. **Voting Period**: 3 days
4. **Quorum**: Minimum 25,000 TORN votes required
5. **Execution**: If passed, 2-day timelock before execution

**Governable Parameters:**
- New token pool additions
- Fee structure changes
- Relayer minimum stake
- Protocol upgrades
- Treasury fund allocation

### 5.3 Voting Mechanism

**Anonymous Voting:**
- Users can vote without revealing identity
- ZK proofs used for vote verification
- Prevents voter tracking and coercion

**Voting Power:**
- 1 TORN = 1 vote
- Delegation supported
- Vote weight = balance at snapshot block

### 5.4 Staking

**Staking Features:**
- Stake TORN to participate in governance
- Earn portion of protocol fees (if enabled)
- Staked TORN used for relayer bonding
- Unstaking period: 7 days

---

## 6. Compliance & Safety Features

### 6.1 Compliance Tool

**Purpose**: Generate compliance reports for regulators/exchanges

**Features:**
- Prove note ownership without revealing deposit transaction
- Export transaction history
- Generate PDF/HTML reports
- Tax reporting assistance

**Technical Implementation:**
```
Compliance Tool Workflow:
1. User inputs note
2. Tool locates corresponding deposit
3. Generates ZK proof of ownership
4. Creates report with:
   - Deposit transaction hash
   - Withdrawal transaction hash
   - Timestamps
   - Amounts
   - Proof of legitimate ownership
```

### 6.2 Proof of Innocence (POI)

**Concept**: Prove withdrawal is NOT from specific deposits

**Use Case**: 
- Exchange/user wants to prove funds aren't from sanctioned addresses
- User wants to demonstrate legitimacy without revealing identity

**How it Works:**
1. User specifies list of "bad" deposits (sanctioned addresses)
2. User generates ZK proof showing their withdrawal is NOT from those deposits
3. Verifier checks proof without learning which deposit was used

**Implementation:**
- Built by Chainway Labs
- Uses exclusion proofs
- Maintains user privacy

### 6.3 Blacklist Integration (0xbow)

**Feature**: Screen deposits against known illicit addresses

**Benefits:**
- Users can avoid deposits from sanctioned addresses
- Maintains anonymity while filtering out "tainted" funds
- Prevents guilt-by-association in public pools

### 6.4 IP Protection Features

**Tor Support:**
- UI accessible via Tor browser (.onion address)
- Hides IP from RPC providers
- Prevents network-level tracking

**VPN Recommendations:**
- Built-in UI warnings about IP logging
- Recommendations for VPN usage
- Privacy-focused RPC providers list

---

## 7. Multi-Chain & Multi-Asset Support

### 7.1 Supported Networks

**Layer 1:**
- Ethereum Mainnet (primary)

**Layer 2 Solutions:**
- Arbitrum One
- Optimism
- Polygon (Matic)
- Gnosis Chain (xDai)

**Alternative L1s:**
- Binance Smart Chain (BSC)
- Avalanche C-Chain

### 7.2 Supported Assets

**Native Tokens:**
- ETH (Ethereum)
- BNB (BSC)
- AVAX (Avalanche)
- MATIC (Polygon)
- xDAI (Gnosis)

**ERC-20 Tokens:**
- DAI (MakerDAO stablecoin)
- USDC (Circle stablecoin)
- USDT (Tether stablecoin)
- WBTC (Wrapped Bitcoin)
- cDAI, cUSDC (Compound tokens)
- yDAI, yUSDC, yUSDT, yTUSD (Yearn vault tokens)

**Adding New Tokens:**
- Governance proposal required
- Audit of token contract
- Deployment of new pool contracts

---

## 8. Tornado Cash Nova (L2) Features

### 8.1 Nova Overview

**Launch Date**: December 2021 (beta)
**Purpose**: Next-generation privacy pool with advanced features
**Status**: Beta version

### 8.2 Arbitrary Amount Deposits

**Feature**: Deposit any amount (not just fixed denominations)

**Benefits:**
- Better capital efficiency
- No need to split/merge amounts
- Natural transaction amounts
- Improved UX

**Trade-offs:**
- Lower anonymity set per amount
- Potential amount-based correlation attacks

### 8.3 Shielded Transfers

**Concept**: Transfer custody without withdrawing from pool

**How it Works:**
1. User A has shielded balance in Nova pool
2. User A generates shielded transfer proof
3. User B receives shielded address
4. Funds move within pool, never touch main chain
5. No on-chain trace between A and B

**Requirements:**
- Recipient must have shielded address (registered account)
- Can transfer partial balances
- Irreversible once executed

### 8.4 Account System

**Shielded Address:**
- Unique address per account
- Generated from shielded key
- Used for receiving shielded transfers
- Separate from Ethereum address

**Shielded Key:**
- Master key for Nova account
- Generated on first deposit or account setup
- Required for logging in
- Must be backed up securely

**Login Methods:**
1. Connect MetaMask (linked address)
2. Enter shielded key directly

### 8.5 L2 Scaling Benefits

**Advantages over Classic:**
- Lower gas costs (90%+ reduction)
- Faster transactions
- More frequent updates
- Better for smaller amounts

---

## 9. Advanced Features

### 9.1 Tornado Trees

**Purpose**: On-chain backup of encrypted notes

**How it Works:**
- Notes encrypted with user's public key
- Stored on-chain via Tornado Proxy
- Only user can decrypt with private key
- Prevents fund loss from lost notes

**Privacy Considerations:**
- Encrypted notes reveal no information
- Still requires user to backup private key
- Optional feature (not required)

### 9.2 Multi-Deposit Aggregation

**Feature**: Deposit to multiple pools in single transaction

**Benefits:**
- Save on gas costs
- Increase participation in multiple anonymity sets
- Diversify privacy across pools

**Implementation:**
- Tornado Proxy batches deposits
- Single transaction, multiple commitments
- Atomic execution (all succeed or all fail)

### 9.3 Recursive ZK-SNARKs (Proposed)

**Concept**: Compress multiple proofs into single proof

**Benefits:**
- Smaller proof sizes
- Faster verification
- Note aggregation
- Improved mobile experience

**Use Cases:**
- Batch withdrawals
- Proof aggregation
- Mobile-friendly proving

### 9.4 SDK & Developer Tools

**Available SDKs:**
- JavaScript/TypeScript SDK
- React components
- CLI tools

**Features:**
- Proof generation APIs
- Contract interaction helpers
- Note management utilities
- Relayer integration

---

## 10. Security Features

### 10.1 Smart Contract Security

**Immutability:**
- Core contracts cannot be upgraded
- No admin keys
- No pause functionality
- Battle-tested since 2019

**Audits:**
- Multiple third-party audits
- Public audit reports
- Bug bounty programs
- Formal verification of circuits

### 10.2 Client-Side Security

**Browser Wallet Integration:**
- No private key storage on servers
- All signing happens in wallet
- No man-in-the-middle risk

**Local Proof Generation:**
- SNARK proofs generated locally
- No server sees secret inputs
- Verifiable computation

### 10.3 Anti-Attack Measures

**Front-Running Protection:**
- Merkle root history (30 blocks)
- Proofs valid across root updates
- No commit-reveal needed

**Replay Attack Prevention:**
- Nullifier uniqueness enforced
- Double-spend impossible
- Chain-specific domains

**Malleability Protection:**
- Strict proof verification
- Input validation
- Constraint checking

### 10.4 Privacy Attack Mitigations

**Timing Analysis:**
- **Attack**: Link deposit/withdraw by timestamp
- **Mitigation**: UI recommends waiting periods
- **Best Practice**: Wait 24+ hours, multiple deposits in between

**Amount Correlation:**
- **Attack**: Link by unique amounts
- **Mitigation**: Fixed denominations in Classic
- **Nova Trade-off**: Arbitrary amounts reduce this protection

**Gas Price Correlation:**
- **Attack**: Same wallet = similar gas prices
- **Mitigation**: Relayer usage breaks this pattern

**Dust Attacks:**
- **Attack**: Attacker deposits tiny amounts to track specific notes
- **Mitigation**: Minimum deposit amounts, large anonymity sets

**Deposit-Withdrawal Graph Analysis:**
- **Attack**: Heuristic linking based on timing + amount patterns
- **Mitigation**: UI warnings, best practice guides

---

## Feature Comparison Matrix

| Feature | Classic | Nova | Notes |
|---------|---------|------|-------|
| Fixed Denominations | ✅ | ❌ | Nova uses arbitrary amounts |
| Arbitrary Amounts | ❌ | ✅ | Nova's key differentiator |
| Shielded Transfers | ❌ | ✅ | Only in Nova |
| Anonymity Mining | ✅ | ✅ | Both support TORN rewards |
| Relayer Support | ✅ | ✅ | Both support relayers |
| Multi-Chain | ✅ | ❌ | Nova is Ethereum-only |
| Compliance Tool | ✅ | ✅ | Works with both |
| Account System | ❌ | ✅ | Nova has shielded accounts |
| Lower Gas | ❌ | ✅ | Nova 90% cheaper |
| Note Backup | ✅ | ✅ | Tornado Trees for both |

---

## Statistics & Metrics (Historical)

**Total Value Locked (TVL) Peak:**
- ~$1 billion (2021-2022)

**Total Deposits:**
- 100,000+ unique addresses
- $7+ billion total volume (lifetime)

**Popular Pools:**
- ETH 0.1: Most deposits
- ETH 1.0: Best anonymity set
- USDC 100: Most stablecoin deposits

**Geographic Distribution:**
- Global usage across 100+ countries
- Highest usage: US, Russia, China, Germany

---

## Resources & Documentation

**Official Links:**
- Website: https://tornado.cash
- Documentation: https://docs.tornado.cash
- GitHub: https://github.com/tornadocash
- Forum: https://torn.community

**Technical Resources:**
- Whitepaper: https://berkeley-defi.github.io/assets/material/Tornado%20Cash%20Whitepaper.pdf
- Circuits: https://github.com/tornadocash/tornado-core/tree/master/circuits
- Contracts: https://github.com/tornadocash/tornado-core/tree/master/contracts
- Tutorial: https://docs.tornado.cash/tornado-cash-classic/circuits

**Developer Tools:**
- SDK: https://github.com/tornadocash/tornado-cli
- Rebuilt (Educational): https://github.com/nkrishang/tornado-cash-rebuilt
- Tutorial: https://zk.bearblog.dev/tornado-cash-manual

---

## Legal & Sanctions Notice

**OFAC Sanctions (August 8, 2022):**
- US Treasury sanctioned Tornado Cash
- US citizens prohibited from interacting with contracts
- Legal challenge ongoing (Van Loon v. Dept of Treasury)
- Smart contracts deemed "not property" in 2024 ruling

**Status:**
- Contracts immutable and operational
- Community maintains UI and documentation
- Usage continues globally (non-US jurisdictions)
- Legal precedent being established

---

*Document compiled from public sources for research and educational purposes.*
*All technical specifications are based on publicly available documentation.*
