# StarkCash / GhostProtocol

> **Privacy Layer for Bitcoin on Starknet**  
> A modular ZK-based privacy protocol utilizing native Starknet cryptography (Poseidon) and high-speed C++ proving.

[![Tests](https://img.shields.io/badge/tests-passing-success)](./tests)  
[![Rust](https://img.shields.io/badge/rust-2021%20edition-orange?logo=rust)](https://www.rust-lang.org/)  
[![Cairo](https://img.shields.io/badge/cairo-2.x-blue)](https://www.cairo-lang.org/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

---

## Overview

**StarkCash** (codename: **GhostProtocol**) is a privacy infrastructure protocol that enables completely private Bitcoin transactions on Starknet. By combining **Groth16 ZK-SNARKs** with Starknet's native **Poseidon** hash function, we achieve industry-leading performance and gas efficiency.

### Key Innovation: GhostPay
GhostProtocol introduces **recipient-agnostic payments** - send private BTC via an encrypted link or QR code. The recipient generates a ZK proof in their browser to claim funds gaslessly via a paymaster.

---

## 🚀 Recent Architectural Pivot: The Poseidon Shift

To achieve "Infrastructure-grade" performance, we pivoted from MiMC7 to **Poseidon Hashing**.

| Metric | Old (MiMC7) | New (Poseidon) | Improvement |
| :--- | :--- | :--- | :--- |
| **Circuit Constraints** | ~12,000 | **5,380** | **55% Faster Proving** |
| **Contract Gas (20-level tree)** | ~4.2 Billion (Panic) | **181,700 Gas** | **23,000x Cheaper** |
| **Proving Time (Rapidsnark)** | ~800ms | **~370ms** | **2x Faster** |

---

## Technology Stack

### 1. The Prover (Rust/C++)
Uses **Rapidsnark** and the **light-poseidon** library to generate Groth16 proofs in under 400ms.
- **Poseidon BN254**: Optimized for ZK-friendliness.
- **Fast Witness Generation**: Powered by Node.js/WASM.

### 2. The Smart Contracts (Cairo 2.x)
Built with modularity using **Starknet Components**.
- **Native Poseidon**: Leverages Starknet's hardware-accelerated built-ins.
- **Garaga Integration**: Uses optimized pairing math for BN254 verification on Stark Curve.
- **U256 Field Math**: Full compatibility with Circom's 254-bit prime field.

### 3. The Infrastructure (Garaga)
We integrated the **Garaga 1.0** core logic directly into the workspace to bypass Python CLI bottlenecks and enable standalone verification.

---

## Project Structure

```
starkcash/
├── circuits/             # Circom 2.2.3 Poseidon Circuits
├── contracts/            # Cairo 2.x Smart Contracts (GhostPool, MerkleTree)
│   └── src/garaga_lib/   # Integrated ZK verification math
├── zkp/                  # Rust Prover (Interfacing with Rapidsnark)
├── src/module/           # Core Rust Cryptography (Poseidon, Commitments)
└── tests/                # Full-stack integration tests
```

---

## Roadmap

### Week 1: Foundation ✅
- [x] Project structure setup
- [x] Poseidon Cryptography module (Rust)
- [x] 100% passing Rust integration tests

### Week 2: Core Infrastructure ✅
- [x] **Circuit Pivot**: Migrated all ZK circuits to Poseidon.
- [x] **Trusted Setup**: Completed Phase 2 for new circuits.
- [x] **Cairo Merkle Tree**: High-performance tree implementation (181k gas).
- [x] **ZK Verifier**: Integrated Garaga 1.0 into Cairo workspace.

### Week 3: Application Layer 🚧
- [ ] **GhostPay**: Rust encryption logic for link-based notes.
- [ ] **Frontend SDK**: React hooks for proof generation.
- [ ] **Starknet Sepolia**: Testnet deployment.

### Week 4: Submission 🚧
- [ ] Account Abstraction (Paymaster)
- [ ] UI/UX Polish
- [ ] Demo Video

---

## Getting Started

### Prerequisites
- **Rust** 1.75+
- **Scarb** 2.15+
- **Circom** 2.2.3
- **Rapidsnark** (Installed in PATH)

### Installation
```bash
git clone https://github.com/ANAVHEOBA/starkcash.git
cd starkcash

# Build Rust backend
cargo build --release

# Run ZKP Integration Tests
cargo test --package starkcash-zkp -- --nocapture

# Build Cairo contracts
cd contracts && scarb build
```

---

## Team
Built for **Starknet Re{define} Hackathon 2026**  
*Privacy is a right, not a privilege.*
