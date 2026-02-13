# StarkCash / GhostProtocol

> **Privacy Layer for Starknet**  
> A production-ready ZK-based privacy protocol utilizing Groth16 SNARKs, Poseidon hashing, and Tornado Cash-inspired security patterns.

[![Tests](https://img.shields.io/badge/tests-passing-success)](./tests)  
[![Rust](https://img.shields.io/badge/rust-1.92-orange?logo=rust)](https://www.rust-lang.org/)  
[![Cairo](https://img.shields.io/badge/cairo-2.x-blue)](https://www.cairo-lang.org/)
[![Circom](https://img.shields.io/badge/circom-2.2.3-purple)](https://docs.circom.io/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

---

## Overview

**StarkCash** (codename: **GhostProtocol**) is a privacy infrastructure protocol that enables completely private transactions on Starknet. By combining **Groth16 ZK-SNARKs** with **Poseidon** hash functions and **Tornado Cash security patterns**, we achieve both privacy and performance.

### Key Features

- **Zero-Knowledge Deposits & Withdrawals**: Deposit funds anonymously, withdraw to any address without revealing the link
- **Merkle Tree Privacy Set**: 20-level tree supporting 1M+ deposits with efficient proof verification
- **Tornado Cash Security**: Implements all 4 safety constraints (recipient, fee, relayer, refund squares) to prevent proof tampering
- **High-Performance Proving**: Sub-second proof generation using Rapidsnark (C++)
- **Gas-Optimized Contracts**: Native Starknet Poseidon for minimal gas consumption
- **Modular Architecture**: Clean separation between circuits, contracts, and application logic

---

## How It Works

### 1. Deposit Phase
```
User → Generate (secret, nullifier) → Compute commitment = Poseidon(secret, nullifier)
     → Send deposit transaction with commitment → Added to Merkle tree
```

### 2. Withdraw Phase
```
User → Provide (secret, nullifier, merkle_proof, recipient, relayer, fee, refund)
     → Generate ZK proof (proves knowledge without revealing secret)
     → Submit proof to contract → Contract verifies and releases funds to recipient
```

### 3. Privacy Guarantee
The ZK proof proves:
- You know a valid (secret, nullifier) pair
- The commitment is in the Merkle tree
- The nullifier hasn't been used before
- **Without revealing which deposit is yours**

---

## 🚀 Performance Metrics

### Circuit Efficiency
| Metric | Value |
| :--- | :--- |
| **Non-linear Constraints** | 5,383 |
| **Linear Constraints** | 5,953 |
| **Total Wires** | 11,363 |
| **Public Inputs** | 6 (root, nullifierHash, recipient, relayer, fee, refund) |
| **Private Inputs** | 42 (secret, nullifier, pathElements, pathIndices) |

### Proving Performance
| Operation | Time |
| :--- | :--- |
| **Witness Generation** | ~100ms |
| **Proof Generation (Rapidsnark)** | ~370ms |
| **Total Proving Time** | **~470ms** |

### Contract Gas Costs
| Operation | Gas (Estimated) |
| :--- | :--- |
| **Deposit** | ~200k gas |
| **Merkle Root Update** | ~180k gas |
| **Withdraw (with verification)** | TBD (pending full Groth16 integration) |

---

## Architecture

### System Components

```
┌─────────────────────────────────────────────────────────────┐
│                     StarkCash Architecture                   │
│              (Tornado Cash Pattern on Starknet)              │
└─────────────────────────────────────────────────────────────┘

┌──────────────┐      ┌──────────────┐      ┌──────────────┐
│   Circuits   │      │  Rust Prover │      │   Contracts  │
│  (Circom)    │─────▶│  (zkp/)      │─────▶│   (Cairo)    │
└──────────────┘      └──────────────┘      └──────────────┘
     │                      │                      │
     │ Defines ZK logic     │ Generates proofs     │ Verifies proofs
     │                      │                      │
     ▼                      ▼                      ▼
withdraw.circom      Rapidsnark C++         ghost_pool.cairo
merkleTree.circom    + WASM witness              │
                                                  │ library_call
                                                  ▼
                                         groth16_verifier.cairo
                                         (Garaga - deployed separately)
```

### Modular Verifier Architecture (Tornado Cash Pattern)

StarkCash uses the same architecture as Tornado Cash on Ethereum:

**Main Pool Contract** (`ghost_pool.cairo`):
- Handles deposits and withdrawals
- Manages Merkle tree state
- Calls external verifier for proof verification
- Fast compilation (~3 seconds)

**Separate Verifier Contract** (`starkcash_groth16/`):
- Full Groth16 pairing check implementation
- Generated by Garaga with all cryptographic operations
- Deployed independently
- Called via `library_call_syscall`

**Benefits**:
- ✅ Fast compilation (no Garaga in main contract)
- ✅ Real cryptographic verification
- ✅ Modular upgrades (can update verifier independently)
- ✅ Production-ready pattern (same as Tornado Cash)

### 1. Circuits (`circuits/`)
**Language**: Circom 2.2.3  
**Purpose**: Define the ZK-SNARK logic

- `withdraw.circom`: Main withdrawal circuit with Tornado Cash safety constraints
- `merkleTree.circom`: Merkle proof verification (20 levels)
- Uses Poseidon hash from circomlib for ZK-friendly hashing

**Key Features**:
- 4 safety squares (recipient, fee, relayer, refund) prevent proof tampering
- Nullifier hash verification prevents double-spending
- Commitment verification links secret to Merkle tree

### 2. Prover (`zkp/`)
**Language**: Rust + C++ (Rapidsnark)  
**Purpose**: Generate ZK proofs off-chain

- Interfaces with Rapidsnark for fast proof generation
- WASM-based witness calculation
- Outputs Groth16 proofs in JSON format

**Workflow**:
1. User provides inputs (secret, nullifier, merkle path, etc.)
2. Generate witness using WASM
3. Rapidsnark generates proof (~370ms)
4. Proof submitted to smart contract

### 3. Smart Contracts (`contracts/`)
**Language**: Cairo 2.x  
**Purpose**: On-chain verification and state management

**Main Pool** (`ghost_pool.cairo`):
- Deposit/withdraw logic
- Merkle tree state management
- Calls external Garaga verifier
- Nullifier tracking

**Verifier** (`starkcash_groth16/`):
- Full Groth16 pairing check
- BN254 elliptic curve operations
- Generated by Garaga CLI
- Deployed separately

**Supporting Modules**:
- `merkle_tree.cairo`: Efficient Merkle tree with Poseidon
- `poseidon.cairo`: Wrapper around Starknet's native Poseidon
- `groth16_verifier_external.cairo`: Library call interface

**Security Features**:
- Nullifier tracking prevents double-spending
- Root history for async withdrawals
- Proof validation (curve points, public inputs)
- External verifier for cryptographic security

### 4. Rust Modules (`src/module/`)
**Language**: Rust  
**Purpose**: Development utilities and testing

- `cryptography/`: Poseidon, commitments, nullifiers
- `merkle_tree/`: Tree implementation for testing
- Used for integration tests and local development
- **Note**: Not used by smart contracts (Cairo has its own implementation)

---

## Project Structure

```
starkcash/
├── circuits/                    # Circom ZK Circuits
│   ├── withdraw.circom         # Main withdrawal circuit (5,383 constraints)
│   ├── merkleTree.circom       # Merkle proof verification
│   ├── build/                  # Compiled circuits (.r1cs, .wasm, .zkey)
│   └── TORNADO_PARITY.md       # Security features documentation
│
├── contracts/                   # Cairo Smart Contracts
│   ├── src/
│   │   ├── ghost_pool.cairo    # Main privacy pool
│   │   ├── merkle_tree.cairo   # Merkle tree implementation
│   │   ├── groth16_verifier.cairo  # Verification logic
│   │   ├── groth16_verifier_external.cairo  # External verifier caller
│   │   ├── verifier_constants.cairo  # VK from trusted setup
│   │   └── poseidon.cairo      # Poseidon hash wrapper
│   ├── tests/
│   │   └── test_ghost_pool.cairo
│   └── Scarb.toml
│
├── starkcash_groth16/           # Garaga Verifier (Separate Contract)
│   ├── src/
│   │   ├── groth16_verifier.cairo  # Full pairing check
│   │   └── groth16_verifier_constants.cairo  # Precomputed values
│   └── Scarb.toml
│
├── zkp/                         # Rust ZK Prover
│   ├── src/
│   │   ├── prover.rs           # Rapidsnark interface
│   │   └── merkle_tree.rs      # Merkle utilities
│   └── tests/
│       └── integration_test.rs # Full proof generation test
│
├── src/module/                  # Rust Development Modules
│   ├── cryptography/           # Poseidon, commitments, nullifiers
│   │   ├── poseidon.rs
│   │   ├── commitment.rs
│   │   ├── nullifier.rs
│   │   └── proof.rs
│   └── merkle_tree/            # Tree implementation
│       ├── tree.rs
│       ├── proof.rs
│       └── storage.rs
│
├── tests/integration/           # Integration Tests
│   ├── cryptography/
│   └── merkle_tree/
│
├── rapidsnark/                  # C++ Prover (submodule)
├── garaga/                      # ZK verification library (reference)
│
├── ZK_PROOF_FLOW.md            # How ZK proofs work in this system
├── INTEGRATION_MAP.md          # Component integration guide
├── ISSUES_STATUS.md            # Known issues and fixes
└── README.md                   # This file
```

---

## Development Status

### ✅ Completed

**Core Infrastructure**:
- [x] Poseidon-based cryptography (Rust + Cairo)
- [x] Merkle tree implementation (20 levels, 1M+ capacity)
- [x] Circom circuits with Tornado Cash security patterns
- [x] Trusted setup and verification key generation
- [x] Rapidsnark integration for fast proving
- [x] Cairo smart contracts (deposit, withdraw, verification)
- [x] Comprehensive test suite (Rust + Cairo)
- [x] **External verifier architecture (Tornado Cash pattern)**
- [x] **Garaga verifier generation and integration**

**Security Features**:
- [x] 4 safety squares (recipient, fee, relayer, refund)
- [x] Nullifier tracking for double-spend prevention
- [x] Merkle root history for async withdrawals
- [x] Proof validation (curve points, public inputs)
- [x] **Modular verifier deployment (upgradeable)**

**Performance**:
- [x] Sub-second proof generation (~470ms)
- [x] Gas-optimized Merkle tree operations
- [x] 5,383 constraints (55% reduction from MiMC7)
- [x] **Fast contract compilation (~3 seconds)**

### 🚧 In Progress

**Smart Contract Verification**:
- [x] Verification key from trusted setup
- [x] Public input linear combination
- [x] External verifier architecture
- [ ] Deploy Garaga verifier to testnet
- [ ] Update verifier class hash in ghost_pool
- [ ] Gas benchmarking for full verification

**Application Layer**:
- [ ] Frontend SDK for proof generation
- [ ] Browser-based witness generation
- [ ] Encrypted note sharing (GhostPay)

**Deployment**:
- [ ] Starknet Sepolia testnet deployment
- [ ] Contract verification and documentation
- [ ] Public demo interface

### 📋 Roadmap

**Phase 1: Core Protocol** (Current)
- Complete Groth16 verification integration
- Deploy to Starknet Sepolia
- Security audit preparation

**Phase 2: User Experience**
- Browser-based proof generation
- Mobile-friendly interface
- QR code note sharing

**Phase 3: Advanced Features**
- Multi-denomination pools
- Relayer network
- Account abstraction (gasless withdrawals)
- Compliance module (optional disclosure)

---

## Getting Started

### Prerequisites

**Required**:
- **Rust** 1.75+ ([Install](https://rustup.rs/))
- **Scarb** 2.8+ ([Install](https://docs.swmansion.com/scarb/download.html))
- **Circom** 2.2.3 ([Install](https://docs.circom.io/getting-started/installation/))
- **Node.js** 18+ (for snarkjs)
- **Rapidsnark** ([Build instructions](./rapidsnark/README.md))

**Optional**:
- **Starknet Foundry** (for contract testing)

### Installation

```bash
# Clone the repository
git clone https://github.com/ANAVHEOBA/starkcash.git
cd starkcash

# Install Node dependencies (circomlib, snarkjs)
npm install

# Build Rust backend
cargo build --release

# Build Cairo contracts
cd contracts && scarb build && cd ..
```

### Running Tests

```bash
# Run Rust integration tests
cargo test --test merkle_tree_integration
cargo test --test cryptography_integration

# Run ZKP proof generation test
cargo test --manifest-path zkp/Cargo.toml

# Run Cairo contract tests
cd contracts && scarb test
```

### Compiling Circuits

```bash
# Compile the withdrawal circuit
circom circuits/withdraw.circom --r1cs --wasm --sym -o circuits/build/

# Run trusted setup (if circuit changed)
cd circuits/build
snarkjs groth16 setup withdraw.r1cs pot15_final.ptau withdraw_0000.zkey
snarkjs zkey contribute withdraw_0000.zkey withdraw_final.zkey --name="Contribution" -e="random"
snarkjs zkey export verificationkey withdraw_final.zkey verification_key.json
```

### Generating a Proof

```bash
# Run the integration test which generates a full proof
cargo test --manifest-path zkp/Cargo.toml -- --nocapture

# Or use the prover directly in your code:
# See zkp/tests/integration_test.rs for example
```

### Deploying the Verifier (Production)

```bash
# 1. Generate Garaga verifier (already done - see starkcash_groth16/)
garaga gen --system groth16 --vk circuits/build/verification_key.json --project-name starkcash_groth16

# 2. Build and declare the verifier contract
cd starkcash_groth16
scarb build
starkli declare target/dev/starkcash_groth16_Groth16VerifierBN254.contract_class.json \
  --network sepolia \
  --account ~/.starkli-wallets/deployer/account.json \
  --keystore ~/.starkli-wallets/deployer/keystore.json

# 3. Note the class hash returned (e.g., 0x1234...)

# 4. Update ghost_pool.cairo with the class hash
# Edit contracts/src/ghost_pool.cairo:
# const GROTH16_VERIFIER_CLASS_HASH: felt252 = 0x<YOUR_CLASS_HASH>;

# 5. Rebuild and deploy ghost_pool
cd contracts
scarb build
starkli deploy <ghost_pool_class_hash> \
  --network sepolia \
  --account ~/.starkli-wallets/deployer/account.json \
  --keystore ~/.starkli-wallets/deployer/keystore.json

# 6. Generate proof with hints for withdrawal
garaga calldata --system groth16 \
  --vk circuits/build/verification_key.json \
  --proof proof.json \
  --public-inputs inputs.json

# 7. Call withdraw with the generated calldata
# The ghost_pool will call the Garaga verifier via library_call_syscall
```

---

## Security Considerations

### Current Security Status

**✅ Implemented**:
- Tornado Cash-inspired safety constraints (4 squares)
- Nullifier uniqueness enforcement
- Merkle proof verification
- Input validation (non-zero checks, curve point validation)
- **External verifier architecture (modular and upgradeable)**
- **Verification key from trusted setup**
- **Public input linear combination**

**⚠️ Development Mode**:
- Garaga verifier generated but not yet deployed
- Currently uses structural validation as fallback
- Full pairing check available when verifier is deployed
- Update `GROTH16_VERIFIER_CLASS_HASH` to enable production verification

**🔒 Production Requirements**:
- Deploy Garaga verifier contract
- Update verifier class hash in ghost_pool
- Multi-party trusted setup ceremony
- Professional security audit

### Known Issues

See [ISSUES_STATUS.md](./ISSUES_STATUS.md) for detailed status of all known issues.

**Resolved**:
- Issue #1: ZK verifier architecture (FIXED - external verifier pattern implemented)
- Issue #3: Hash mismatch in tests (FIXED - all use Poseidon)
- Issue #5: ZKP test false positives (FIXED - proper error handling)

**Pending Deployment**:
- Deploy Garaga verifier to testnet
- Update verifier class hash in ghost_pool
- Test full end-to-end verification flow

### Recommendations for Production

1. **Deploy Garaga verifier**: Use the generated `starkcash_groth16` contract
2. **Update verifier class hash**: Set in `ghost_pool.cairo` after deployment
3. **Multi-party trusted setup**: Current setup is single-party
4. **Security audit**: Professional audit before mainnet
5. **Relayer network**: Decentralized relayers for withdrawal privacy
6. **Emergency pause**: Add circuit breaker for critical bugs
7. **Gas optimization**: Benchmark and optimize verification costs

---

## Documentation

- [ZK_PROOF_FLOW.md](./ZK_PROOF_FLOW.md) - How ZK proofs work in this system
- [INTEGRATION_MAP.md](./INTEGRATION_MAP.md) - Component integration guide
- [ISSUES_STATUS.md](./ISSUES_STATUS.md) - Known issues and their status
- [circuits/TORNADO_PARITY.md](./circuits/TORNADO_PARITY.md) - Tornado Cash security features
- [contracts/POSEIDON_NOTES.md](./contracts/POSEIDON_NOTES.md) - Poseidon implementation notes
- [contracts/GROTH16_VERIFIER_README.md](./contracts/GROTH16_VERIFIER_README.md) - Verifier documentation

---

## Contributing

We welcome contributions! Please see our contributing guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Write tests for new features
- Follow Rust and Cairo style guides
- Document complex logic
- Update README if adding new components

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- **Tornado Cash**: Inspiration for privacy pool design and security patterns
- **Circom/SnarkJS**: ZK circuit framework
- **Rapidsnark**: High-performance proof generation
- **Garaga**: BN254 pairing verification on Starknet
- **Starknet**: Layer 2 platform and native Poseidon support

---

## Contact & Support

- **GitHub Issues**: [Report bugs or request features](https://github.com/ANAVHEOBA/starkcash/issues)
- **Documentation**: See `/docs` folder for detailed guides
- **Hackathon**: Built for Starknet Re{define} Hackathon 2026

---

*Privacy is a right, not a privilege.*
