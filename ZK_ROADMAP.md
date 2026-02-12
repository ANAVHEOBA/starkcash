# GhostProtocol ZK Implementation Roadmap (C++ Rapidsnark)

> **Goal**: Complete all ZK infrastructure before moving to smart contracts  
> **Approach**: Circom circuits + C++ rapidsnark (20x faster than snarkjs)  
> **Speed**: 20x faster proving with native C++  
> **Status**: Foundation complete, ready for circuits

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    GHOSTPROTOCOL ZK LAYER                   │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────┐        ┌──────────────────────────┐      │
│  │   Circom     │        │        Rust              │      │
│  │  Circuits    │        │                          │      │
│  │              │        │  ┌──────────────────┐   │      │
│  │ withdraw.    │───────▶│  │  ZkProver        │   │      │
│  │   circom     │compile │  │                  │   │      │
│  │              │        │  │ Calls C++        │   │      │
│  │ MiMC (lib)   │        │  │ rapidsnark       │   │      │
│  │ MerkleTree   │        │  │ binary           │   │      │
│  │   (lib)      │        │  │ (20x faster!)    │   │      │
│  └──────────────┘        │  └──────────────────┘   │      │
│                          │                          │      │
│  ┌──────────────┐        │  ┌──────────────────┐   │      │
│  │  Trusted     │        │  │  MerkleTree      │   │      │
│  │   Setup      │        │  │                  │   │      │
│  │              │        │  │ Uses existing    │   │      │
│  │ • Powers of  │        │  │ MiMC7 from       │   │      │
│  │   Tau        │        │  │ starkcash::      │   │      │
│  │ • ZKEY gen   │        │  │ cryptography     │   │      │
│  └──────────────┘        │  └──────────────────┘   │      │
│                          └──────────────────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

**Why C++ rapidsnark?**
- **20x faster** than JavaScript snarkjs
- **Native performance** compiled to machine code
- **Same circuits** as Tornado Cash
- **Production grade** used by major projects

---

## Current Status

### ✅ COMPLETED (Week 1)
- [x] Rust cryptography primitives (MiMC7, commitments, nullifiers)
- [x] 104 integration tests passing
- [x] Research documentation

### 🚧 REMAINING (Week 2-3)
- [ ] Install C++ build tools (cmake, gmp)
- [ ] Compile rapidsnark from source
- [ ] Write Circom circuits (withdraw.circom)
- [ ] Create Rust ZK module (zkp/)
- [ ] Implement Merkle tree in Rust
- [ ] Run trusted setup
- [ ] Test proof generation with C++

---

## New Project Structure

```
starkcash/
├── circuits/                          # Circom circuits
│   ├── withdraw.circom
│   └── build/
│       ├── withdraw.r1cs
│       ├── withdraw.wasm
│       ├── withdraw_final.zkey
│       └── verification_key.json
│
├── zkp/                              # Rust ZK module
│   ├── Cargo.toml
│   └── src/
│       ├── lib.rs
│       ├── prover.rs                 # Calls C++ rapidsnark
│       └── merkle_tree.rs            # Uses your MiMC7
│
├── contracts/                        # Cairo contracts (later)
│   └── src/
│       └── GhostPool.cairo
│
├── src/                              # Your existing crypto
│   └── module/
│       └── cryptography/
│
├── scripts/
│   ├── setup.sh                      # Install rapidsnark
│   ├── compile.sh                    # Compile circuits
│   └── trusted_setup.sh              # Run trusted setup
│
├── package.json                      # Only for circom compiler
├── Cargo.toml                      # Workspace config
└── ZK_ROADMAP.md
```

---

## Phase 1: Install C++ Toolchain (Day 1)

### 1.1 Install Build Dependencies

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install -y cmake build-essential libgmp-dev libsodium-dev nasm
```

**macOS:**
```bash
brew install cmake gmp libsodium nasm
```

**Verify installations:**
```bash
cmake --version    # Should be 3.16+
gcc --version      # Should work
```

### 1.2 Install Node.js (only for circom compiler)
```bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install -g circom
```

### 1.3 Create Directory Structure
```bash
mkdir -p circuits/build zkp/src contracts/src scripts
npm init -y
```

**Deliverables:**
- [ ] cmake installed
- [ ] gmp (GNU Multiple Precision) installed
- [ ] nasm installed
- [ ] circom installed
- [ ] Directory structure created

---

## Phase 2: Compile Rapidsnark from Source (Day 1)

### 2.1 Clone and Build

```bash
cd ~  # Or your preferred location
git clone https://github.com/iden3/rapidsnark.git
cd rapidsnark

# Install node dependencies
npm install

# Initialize submodules
git submodule update --init --recursive

# Build GMP library
./build_gmp.sh host

# Create build directory
mkdir -p build_prover
cd build_prover

# Configure with CMake
cmake .. -DCMAKE_BUILD_TYPE=Release

# Compile (use all CPU cores)
make -j$(nproc)  # Linux
# OR
make -j$(sysctl -n hw.ncpu)  # macOS
```

### 2.2 Install Globally

```bash
# Copy binary to system path
sudo cp src/rapidsnark /usr/local/bin/

# Verify installation
rapidsnark --help
```

**Expected output:**
```
Usage: rapidsnark <proving_key.zkey> <input.json> <proof.json> <public.json>
```

### 2.3 Test Rapidsnark
```bash
# Create test directory
mkdir -p ~/rapidsnark-test
cd ~/rapidsnark-test

# Create simple test input
echo '{"a": 3, "b": 11}' > input.json

# Test (need actual circuit files, but verify binary works)
which rapidsnark
rapidsnark --help
```

**Deliverables:**
- [ ] rapidsnark cloned and compiled
- [ ] Binary installed to /usr/local/bin/
- [ ] `rapidsnark --help` works
- [ ] ~20x faster than JavaScript ready

---

## Phase 3: Write Circuits (Day 1-2)

### 3.1 Install circomlib

```bash
npm install circomlib
```

### 3.2 withdraw.circom

**File**: `circuits/withdraw.circom`

```circom
pragma circom 2.0.0;

include "node_modules/circomlib/circuits/mimc.circom";
include "node_modules/circomlib/circuits/merkletree.circom";
include "node_modules/circomlib/circuits/comparators.circom";

template Withdraw(levels) {
    // Public inputs (visible on-chain)
    signal input root;
    signal input nullifierHash;
    signal input recipient;
    signal input relayer;
    signal input fee;
    signal input refund;
    
    // Private inputs (hidden)
    signal input secret;
    signal input nullifier;
    signal input pathElements[levels];
    signal input pathIndices[levels];
    
    // Compute commitment = MiMC(secret, 0)
    component commitmentHasher = MiMC7();
    commitmentHasher.x_in <== secret;
    commitmentHasher.k <== 0;
    
    signal commitment;
    commitment <== commitmentHasher.out;
    
    // Compute nullifierHash = MiMC(nullifier, 0)
    component nullifierHasher = MiMC7();
    nullifierHasher.x_in <== nullifier;
    nullifierHasher.k <== 0;
    
    // Constraint: computed nullifier hash must match
    nullifierHasher.out === nullifierHash;
    
    // Verify Merkle proof
    component tree = MerkleTreeChecker(levels);
    tree.leaf <== commitment;
    tree.root <== root;
    
    for (var i = 0; i < levels; i++) {
        tree.pathElements[i] <== pathElements[i];
        tree.pathIndices[i] <== pathIndices[i];
    }
    
    // Fee must be less than denomination
    component feeChecker = LessThan(252);
    feeChecker.in[0] <== fee;
    feeChecker.in[1] <== 1000000000000000000;
    feeChecker.out === 1;
}

// Instantiate with 20 levels (1M capacity)
component main = Withdraw(20);
```

**Estimated constraints:** ~12,000

### 3.3 Compile Circuit

```bash
circom circuits/withdraw.circom --r1cs --wasm --sym -o circuits/build/
```

**Output files:**
- `withdraw.r1cs` - Constraint system
- `withdraw.wasm` - Witness generator
- `withdraw.sym` - Debug symbols

**Deliverables:**
- [ ] `withdraw.circom` written
- [ ] Circuit compiles without errors
- [ ] `.r1cs` and `.wasm` files generated

---

## Phase 4: Rust ZK Module (Day 2-3)

### 4.1 Update Cargo.toml for Workspace

**File**: `Cargo.toml` (root)
```toml
[workspace]
members = [".", "zkp"]

[package]
name = "starkcash"
version = "0.1.0"
edition = "2021"
```

### 4.2 Create zkp/Cargo.toml

**File**: `zkp/Cargo.toml`
```toml
[package]
name = "starkcash-zkp"
version = "0.1.0"
edition = "2021"

[dependencies]
starkcash = { path = ".." }
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
hex = "0.4"

[dev-dependencies]
tokio = { version = "1.0", features = ["full"] }
```

### 4.3 Merkle Tree Implementation

**File**: `zkp/src/merkle_tree.rs`

Uses YOUR existing MiMC7:

```rust
//! Incremental Merkle Tree
//! Uses starkcash::cryptography::mimc7_hash

use starkcash::cryptography::mimc7_hash;

pub const LEVELS: usize = 20;
pub const CAPACITY: usize = 1 << LEVELS;
pub const ROOT_HISTORY_SIZE: usize = 30;

pub struct IncrementalMerkleTree {
    levels: usize,
    filled_subtrees: Vec<[u8; 32]>,
    zeros: Vec<[u8; 32]>,
    next_index: usize,
    roots: Vec<[u8; 32]>,
    current_root_index: usize,
}

impl IncrementalMerkleTree {
    pub fn new(levels: usize) -> Self {
        let mut zeros = vec![[0u8; 32]; levels];
        
        // Precompute zero hashes using YOUR MiMC7
        for i in 1..levels {
            zeros[i] = mimc7_hash(&zeros[i-1], &zeros[i-1]);
        }
        
        let root = zeros[levels - 1];
        
        Self {
            levels,
            filled_subtrees: zeros.clone(),
            zeros,
            next_index: 0,
            roots: vec![root; ROOT_HISTORY_SIZE],
            current_root_index: 0,
        }
    }
    
    pub fn insert(&mut self, leaf: [u8; 32]) -> [u8; 32] {
        let mut current_hash = leaf;
        let mut current_index = self.next_index;
        
        for i in 0..self.levels {
            if current_index % 2 == 0 {
                self.filled_subtrees[i] = current_hash;
                current_hash = mimc7_hash(&current_hash, &self.zeros[i]);
            } else {
                current_hash = mimc7_hash(&self.filled_subtrees[i], &current_hash);
            }
            current_index /= 2;
        }
        
        self.current_root_index = (self.current_root_index + 1) % ROOT_HISTORY_SIZE;
        self.roots[self.current_root_index] = current_hash;
        self.next_index += 1;
        
        current_hash
    }
    
    pub fn root(&self) -> [u8; 32] {
        self.roots[self.current_root_index]
    }
    
    pub fn is_known_root(&self, root: [u8; 32]) -> bool {
        self.roots.iter().any(|&r| r == root)
    }
}

#[derive(Debug)]
pub struct MerkleProof {
    pub path_elements: Vec<[u8; 32]>,
    pub path_indices: Vec<u8>,
    pub root: [u8; 32],
}
```

### 4.4 ZK Prover (Calls C++ rapidsnark)

**File**: `zkp/src/prover.rs`

```rust
//! ZK Proof Generation using C++ rapidsnark

use std::process::Command;
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize)]
pub struct ProofInput {
    pub root: String,
    pub nullifier_hash: String,
    pub recipient: String,
    pub relayer: String,
    pub fee: String,
    pub refund: String,
    pub secret: String,
    pub nullifier: String,
    pub path_elements: Vec<String>,
    pub path_indices: Vec<u32>,
}

#[derive(Debug, Deserialize)]
pub struct Proof {
    pub pi_a: Vec<String>,
    pub pi_b: Vec<Vec<String>>,
    pub pi_c: Vec<String>,
}

#[derive(Debug, Deserialize)]
pub struct PublicSignals {
    pub root: String,
    pub nullifier_hash: String,
    pub recipient: String,
    pub relayer: String,
    pub fee: String,
    pub refund: String,
}

pub struct ZkProver {
    zkey_path: String,
}

impl ZkProver {
    pub fn new(zkey_path: &str) -> Self {
        Self {
            zkey_path: zkey_path.to_string(),
        }
    }
    
    /// Generate ZK proof using C++ rapidsnark
    /// ~20x faster than JavaScript snarkjs
    pub fn generate_proof(&self, input: &ProofInput) -> Result<(Proof, PublicSignals), String> {
        // Create temp files
        let temp_dir = std::env::temp_dir();
        let input_path = temp_dir.join("proof_input.json");
        let proof_path = temp_dir.join("proof.json");
        let public_path = temp_dir.join("public.json");
        
        // Write input
        let input_json = serde_json::to_string_pretty(input)
            .map_err(|e| format!("Serialize error: {}", e))?;
        
        std::fs::write(&input_path, input_json)
            .map_err(|e| format!("Write error: {}", e))?;
        
        // Call C++ rapidsnark (20x faster!)
        let output = Command::new("rapidsnark")
            .args(&[
                &self.zkey_path,
                &input_path.to_string_lossy(),
                &proof_path.to_string_lossy(),
                &public_path.to_string_lossy(),
            ])
            .output()
            .map_err(|e| format!("Rapidsnark not found. Did you install it? Error: {}", e))?;
        
        if !output.status.success() {
            let stderr = String::from_utf8_lossy(&output.stderr);
            return Err(format!("Rapidsnark failed: {}", stderr));
        }
        
        // Read proof
        let proof_json = std::fs::read_to_string(&proof_path)
            .map_err(|e| format!("Read proof error: {}", e))?;
        let proof: Proof = serde_json::from_str(&proof_json)
            .map_err(|e| format!("Parse proof error: {}", e))?;
        
        // Read public signals
        let public_json = std::fs::read_to_string(&public_path)
            .map_err(|e| format!("Read public error: {}", e))?;
        let public_signals: PublicSignals = serde_json::from_str(&public_json)
            .map_err(|e| format!("Parse public error: {}", e))?;
        
        Ok((proof, public_signals))
    }
}
```

### 4.5 Module Exports

**File**: `zkp/src/lib.rs`
```rust
pub mod merkle_tree;
pub mod prover;

pub use merkle_tree::{IncrementalMerkleTree, MerkleProof, LEVELS};
pub use prover::{Proof, ProofInput, PublicSignals, ZkProver};
```

**Deliverables:**
- [ ] Workspace configured
- [ ] Merkle tree uses your MiMC7
- [ ] Prover calls C++ rapidsnark
- [ ] Module compiles

---

## Phase 5: Trusted Setup (Day 3-4)

### 5.1 Download Powers of Tau

```bash
cd circuits/build

# Download ceremony file (~5GB)
wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_20.ptau

# Or use curl if wget not available
curl -O https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_20.ptau
```

### 5.2 Run Trusted Setup

**Note**: This requires snarkjs for setup phase only (can't use rapidsnark for setup)

```bash
npm install -g snarkjs

# Phase 2 setup
snarkjs groth16 setup withdraw.r1cs powersOfTau28_hez_final_20.ptau withdraw_0000.zkey

# Contribute randomness
snarkjs zkey contribute withdraw_0000.zkey withdraw_final.zkey --name="GhostProtocol" -v

# Export verification key
snarkjs zkey export verificationkey withdraw_final.zkey verification_key.json
```

**Deliverables:**
- [ ] Powers of Tau downloaded
- [ ] withdraw_final.zkey created
- [ ] verification_key.json exported

---

## Phase 6: Testing (Day 4-5)

### 6.1 Create Integration Test

**File**: `zkp/tests/integration_test.rs`

```rust
use starkcash_zkp::{IncrementalMerkleTree, ZkProver, ProofInput};
use starkcash::cryptography::*;

#[test]
fn test_full_withdraw_flow_with_rapidsnark() {
    // 1. Create tree
    let mut tree = IncrementalMerkleTree::new(20);
    
    // 2. Generate commitment (YOUR existing Rust code!)
    let secret = random_bytes32();
    let commitment = generate_commitment(&secret);
    
    // 3. Deposit
    let root = tree.insert(commitment.hash);
    
    // 4. Generate nullifier (YOUR existing Rust code!)
    let seed = random_bytes32();
    let nullifier = generate_nullifier(&secret, &seed);
    let nullifier_hash = generate_nullifier_hash(&nullifier);
    
    // 5. Create proof input
    // Note: path_elements simplified for test
    let input = ProofInput {
        root: hex::encode(&root),
        nullifier_hash: hex::encode(&nullifier_hash.hash),
        recipient: "0x1234567890abcdef".to_string(),
        relayer: "0x0000000000000000".to_string(),
        fee: "0".to_string(),
        refund: "0".to_string(),
        secret: hex::encode(&secret),
        nullifier: hex::encode(&nullifier.nullifier),
        path_elements: vec![hex::encode([0u8; 32]); 20], // Simplified
        path_indices: vec![0; 20],
    };
    
    // 6. Generate proof with C++ rapidsnark
    let prover = ZkProver::new("circuits/build/withdraw_final.zkey");
    
    let start = std::time::Instant::now();
    let (proof, public_signals) = prover.generate_proof(&input)
        .expect("Proof generation failed");
    let duration = start.elapsed();
    
    println!("Proof generated in: {:?}", duration);
    println!("Expected: < 500ms with rapidsnark");
    
    // 7. Verify
    assert_eq!(public_signals.root, hex::encode(&root));
    assert_eq!(public_signals.nullifier_hash, hex::encode(&nullifier_hash.hash));
}
```

### 6.2 Run Tests

```bash
# Ensure rapidsnark is in PATH
which rapidsnark

# Run tests
cargo test --package starkcash-zkp -- --nocapture
```

**Expected output:**
```
Proof generated in: 245.32ms
Expected: < 500ms with rapidsnark
✓ test_full_withdraw_flow_with_rapidsnark
```

**Deliverables:**
- [ ] Test passes
- [ ] Proof generation < 500ms
- [ ] Proof verification works

---

## Completion Checklist

- [ ] C++ build tools installed (cmake, gmp, nasm)
- [ ] Rapidsnark compiled and installed
- [ ] `rapidsnark --help` works
- [ ] withdraw.circom written and compiled
- [ ] Workspace configured
- [ ] Merkle tree implemented (uses your MiMC7)
- [ ] Prover calls C++ rapidsnark
- [ ] Trusted setup complete
- [ ] verification_key.json exported
- [ ] Tests passing with < 500ms proof time

---

## Performance Expectations

| Metric | snarkjs (JS) | rapidsnark (C++) | Improvement |
|--------|-------------|------------------|-------------|
| Proof generation | 5-10 seconds | 200-500ms | **20x faster** |
| Witness generation | 1-2 seconds | 100-200ms | **10x faster** |
| Memory usage | High | Low | Better |
| Binary size | N/A (JS) | ~5MB | Standalone |

---

## Commands to Start NOW

```bash
# 1. Install C++ tools (Ubuntu)
sudo apt-get install -y cmake build-essential libgmp-dev libsodium-dev nasm

# 2. Install Node.js (for circom only)
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install -g circom

# 3. Compile rapidsnark
git clone https://github.com/iden3/rapidsnark.git ~/rapidsnark
cd ~/rapidsnark
npm install
git submodule update --init --recursive
./build_gmp.sh host
mkdir build_prover && cd build_prover
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
sudo cp src/rapidsnark /usr/local/bin/

# 4. Create project structure
mkdir -p starkcash-circuits zkp/src scripts
cd starkcash-circuits
npm init -y
npm install circomlib

# 5. Verify
echo "Rapidsnark version:"
rapidsnark --help
```

---

## Troubleshooting

### Rapidsnark build fails?
```bash
# Try with specific compiler
CC=gcc CXX=g++ cmake .. -DCMAKE_BUILD_TYPE=Release
```

### GMP not found?
```bash
# Ubuntu
sudo apt-get install libgmp-dev

# macOS
brew install gmp
```

### Permission denied?
```bash
sudo chmod +x /usr/local/bin/rapidsnark
```

---

## Deliverables for Smart Contract Phase

1. **circuits/build/**:
   - withdraw.r1cs
   - withdraw.wasm
   - withdraw_final.zkey
   - verification_key.json

2. **zkp/**:
   - Rust module with Merkle tree
   - Prover calling C++ rapidsnark

3. **Test artifacts**:
   - Example proofs
   - < 500ms generation time

---

## Summary

**Approach**: Circom + C++ rapidsnark (20x faster)  
**Your Rust Code**: Powers Merkle tree using your MiMC7  
**Speed**: < 500ms proof generation  
**Time**: 5-7 days  

**Start with**: Install cmake, gmp, nasm, then compile rapidsnark
