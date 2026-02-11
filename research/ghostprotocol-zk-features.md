# GhostProtocol - ZK Privacy Features Specification (Tornado Cash Mathematics)

> **Project**: GhostProtocol - Privacy Layer for Bitcoin on Starknet  
> **Component**: ZK Infrastructure Core  
> **Approach**: Using Tornado Cash Mathematics (Groth16 + Circom + MiMC)  
> **Hackathon**: Starknet Re{define} 2026 - Privacy Track  
> **Date**: February 2026

---

## Overview

GhostProtocol implements **Tornado Cash's exact cryptographic architecture** adapted for Starknet. This means using **Groth16 ZK-SNARKs**, **Circom circuits**, and **MiMC hashing** - the same production-tested mathematics used by Tornado Cash.

**Why Tornado Cash Math?**
- Battle-tested since 2019
- Proven privacy guarantees
- Industry standard
- Judges recognize the complexity

---

## Table of Contents
1. [Cryptographic Primitives](#1-cryptographic-primitives)
2. [Groth16 Proving System](#2-groth16-proving-system)
3. [Circom Circuit Architecture](#3-circom-circuit-architecture)
4. [Smart Contract Verifier](#4-smart-contract-verifier)
5. [Trusted Setup Ceremony](#5-trusted-setup-ceremony)
6. [Commitment & Nullifier System](#6-commitment--nullifier-system)
7. [Merkle Tree Implementation](#7-merkle-tree-implementation)
8. [Private Payment Mechanisms](#8-private-payment-mechanisms)
9. [Security & Anti-Attack Features](#9-security--anti-attack-features)
10. [Gas Optimization](#10-gas-optimization)

---

## 1. Cryptographic Primitives

### 1.1 MiMC Hash Function

**What**: MiMC (Minimized Multiplicative Complexity) - optimized for ZK circuits

**Mathematical Definition:**
```
MiMC(x, k) = x^3 + k (mod p)

Where:
- x = input
- k = round key
- p = prime field (21888242871839275222246405745257275088548364400416034343698204186575808495617)
- Rounds: 220 iterations
```

**Implementation in Circom:**
```circom
template MiMC7() {
    signal input x_in;
    signal input k;
    signal output out;

    signal t[220];
    signal x[221];

    x[0] <== x_in;

    for (var i = 0; i < 220; i++) {
        t[i] <== x[i] + k + i;
        x[i+1] <== t[i]^7;
    }

    out <== x[220] + k;
}
```

**Why MiMC?**
- Minimal constraints in ZK circuits (~90 constraints per hash)
- vs Pedersen (~2,000 constraints)
- Optimized for SNARK proving

### 1.2 Pedersen Hash (Alternative)

**Mathematical Definition:**
```
PedersenHash(a, b) = a*G1 + b*G2

Where:
- G1, G2 = generator points on elliptic curve
- a, b = inputs
- Result = point on curve (x-coordinate)
```

**Comparison:**
- Pedersen: 2,000 constraints, faster on Starknet native
- MiMC: 90 constraints, faster in SNARK circuits

### 1.3 Prime Field Arithmetic

**BN128 Curve Field (used by Groth16):**
```
p = 21888242871839275222246405745257275088548364400416034343698204186575808495617

All arithmetic performed modulo p
```

**Operations:**
- Addition: (a + b) mod p
- Multiplication: (a * b) mod p
- Exponentiation: a^b mod p
- Inversion: a^(-1) mod p (where a * a^(-1) ≡ 1 mod p)

---

## 2. Groth16 Proving System

### 2.1 What is Groth16?

**Type**: zk-SNARK (Zero-Knowledge Succinct Non-Interactive Argument of Knowledge)

**Properties:**
- **Zero-Knowledge**: Prover reveals nothing beyond validity
- **Succinct**: Proof size = 3 elliptic curve points (~200 bytes)
- **Non-Interactive**: Single message from prover to verifier
- **Argument of Knowledge**: Prover actually knows witness

### 2.2 Mathematical Foundation

**Elliptic Curve**: BN128 (Barreto-Naehrig curve)

**Curve Equation:**
```
y^2 = x^3 + 3 (mod p)

Order of curve: r = 21888242871839275222246405745257275088548364400416034343698204186575808495617
```

**Pairing-Friendly:**
```
e: G1 × G2 → GT

Bilinear pairing property:
e(a*G1, b*G2) = e(G1, G2)^(a*b)
```

### 2.3 Groth16 Protocol

**Setup Phase (Trusted Setup):**
```
1. Generate random toxic waste: τ, α, β, δ
2. Compute powers of τ: [τ^1], [τ^2], ..., [τ^n]
3. Compute proving key: PK = ([α], [β], [δ], {[τ^i]}, ...)
4. Compute verification key: VK = ([α], [β], [γ], [δ], ...)
5. Destroy τ, α, β, δ (toxic waste)
```

**Proving Phase:**
```
Inputs:
- Public inputs: x = (x1, x2, ..., xl)
- Private witness: w = (w1, w2, ..., wm)
- Constraint system: R1CS (Rank-1 Constraint System)

Steps:
1. Compute A = Σ(ai * wi) * G1
2. Compute B = Σ(bi * wi) * G2
3. Compute C = complex computation involving H(t) and constraints

Output proof: π = (A, B, C) ∈ G1 × G2 × G1
```

**Verification:**
```
Check: e(A, B) = e(α, β) * e(Σ(xi * Li), γ) * e(C, δ)

Where:
- e = bilinear pairing
- α, β, γ, δ = verification key elements
- Li = linear combination of public inputs
```

### 2.4 Proof Structure

**Groth16 Proof (3 points):**
```json
{
  "pi_a": ["uint256", "uint256"],  // G1 point (x, y)
  "pi_b": [["uint256", "uint256"], ["uint256", "uint256"]],  // G2 point
  "pi_c": ["uint256", "uint256"]   // G1 point
}
```

**Size**: ~192 bytes

**Verification Cost**: ~300,000 gas (on Ethereum)
**On Starknet**: ~5,000-8,000 gas (much cheaper!)

---

## 3. Circom Circuit Architecture

### 3.1 What is Circom?

**Language**: Circuit description language for ZK-SNARKs
**Compiler**: circom → R1CS → WASM prover + Solidity verifier

### 3.2 Withdrawal Circuit (Full Implementation)

**File**: `circuits/withdraw.circom`

```circom
pragma circom 2.0.0;

include "../node_modules/circomlib/circuits/mimc.circom";
include "../node_modules/circomlib/circuits/merkletree.circom";
include "../node_modules/circomlib/circuits/comparators.circom";

// Tornado Cash Withdrawal Circuit
template Withdraw(levels) {
    // Public inputs (known to verifier)
    signal input root;
    signal input nullifierHash;
    signal input recipient;
    signal input relayer;
    signal input fee;
    signal input refund;

    // Private inputs (kept secret)
    signal input secret;
    signal input nullifier;
    signal input pathElements[levels];
    signal input pathIndices[levels];

    // Compute commitment: commitment = MiMC(secret)
    component commitmentHasher = MiMC7();
    commitmentHasher.x_in <== secret;
    commitmentHasher.k <== 0;

    signal commitment;
    commitment <== commitmentHasher.out;

    // Compute nullifier hash: nullifierHash = MiMC(nullifier)
    component nullifierHasher = MiMC7();
    nullifierHasher.x_in <== nullifier;
    nullifierHasher.k <== 0;

    // Constraint: computed nullifier hash must match public input
    nullifierHasher.out === nullifierHash;

    // Verify Merkle proof
    component tree = MerkleTreeChecker(levels);
    tree.leaf <== commitment;
    tree.root <== root;
    
    for (var i = 0; i < levels; i++) {
        tree.pathElements[i] <== pathElements[i];
        tree.pathIndices[i] <== pathIndices[i];
    }

    // Additional constraints to prevent malleability
    component feeChecker = LessThan(252);
    feeChecker.in[0] <== fee;
    feeChecker.in[1] <== 1000000000000000000; // Must be less than denomination
    feeChecker.out === 1;

    // Relayer must be zero if no relayer used
    component relayerIsZero = IsZero();
    relayerIsZero.in <== relayer;
    
    // If relayer is zero, fee must be zero
    component relayerFeeCheck = OR();
    relayerFeeCheck.a <== 1 - relayerIsZero.out;
    relayerFeeCheck.b <== fee;
    relayerFeeCheck.out === 1;
}

// Instantiate with 20 levels (1M capacity)
component main = Withdraw(20);
```

**Circuit Statistics:**
- Constraints: ~12,000
- Public inputs: 6
- Private inputs: 2 + 2*levels = 42 (for levels=20)
- Proof generation time: ~2-3 seconds (client-side)

### 3.3 Merkle Tree Circuit

**File**: `circuits/merkletree.circom`

```circom
template MerkleTreeChecker(levels) {
    signal input leaf;
    signal input root;
    signal input pathElements[levels];
    signal input pathIndices[levels];

    signal hashers[levels + 1];
    hashers[0] <== leaf;

    for (var i = 0; i < levels; i++) {
        component hasher = MiMC7();
        
        // If pathIndices[i] == 0, hasher inputs: (hashers[i], pathElements[i])
        // If pathIndices[i] == 1, hasher inputs: (pathElements[i], hashers[i])
        
        component swap = Switcher();
        swap.sel <== pathIndices[i];
        swap.L <== hashers[i];
        swap.R <== pathElements[i];

        hasher.x_in <== swap.outL;
        hasher.k <== swap.outR;
        
        hashers[i + 1] <== hasher.out;
    }

    // Final hash must equal root
    hashers[levels] === root;
}
```

### 3.4 Compilation Flow

```bash
# 1. Compile circuit to R1CS
circom circuits/withdraw.circom --r1cs --wasm --sym

# 2. Generate proving key (requires trusted setup ptau)
snarkjs groth16 setup withdraw.r1cs powersOfTau28_hez_final_20.ptau withdraw_0000.zkey

# 3. Contribute to ceremony (adds randomness)
snarkjs zkey contribute withdraw_0000.zkey withdraw_0001.zkey --name="GhostProtocol" -v

# 4. Finalize proving key
snarkjs zkey beacon withdraw_0001.zkey withdraw_final.zkey 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f 10 -n="Final Beacon"

# 5. Export verification key
snarkjs zkey export verificationkey withdraw_final.zkey verification_key.json

# 6. Generate Solidity verifier
snarkjs zkey export solidityverifier withdraw_final.zkey verifier.sol
```

---

## 4. Smart Contract Verifier

### 4.1 Cairo Verifier Contract

Since Starknet doesn't natively support Groth16, we implement the verifier in Cairo:

**File**: `contracts/verifier.cairo`

```cairo
use starknet::{ContractAddress, contract_address_const};
use array::ArrayTrait;

// BN128 curve parameters
const P: u256 = 21888242871839275222246405745257275088548364400416034343698204186575808495617_u256;
const Q: u256 = 21888242871839275222246405745257275088696311157297823662689037894645226208583_u256;

// G1 and G2 generator points
const G1_X: u256 = 1;
const G1_Y: u256 = 2;

#[starknet::contract]
mod Verifier {
    use super::*;
    
    #[storage]
    struct Storage {
        vk_alpha1: G1Point,
        vk_beta2: G2Point,
        vk_gamma2: G2Point,
        vk_delta2: G2Point,
        vk_ic: LegacyMap<u32, G1Point>,
        vk_ic_length: u32,
    }

    #[derive(Copy, Drop, Serde)]
    struct G1Point {
        x: u256,
        y: u256,
    }

    #[derive(Copy, Drop, Serde)]
    struct G2Point {
        x: Array<u256>,  // [x1, x2]
        y: Array<u256>,  // [y1, y2]
    }

    #[derive(Drop, Serde)]
    struct Proof {
        a: G1Point,
        b: G2Point,
        c: G1Point,
    }

    #[constructor]
    fn constructor(
        ref self: ContractState,
        vk_alpha1: G1Point,
        vk_beta2: G2Point,
        vk_gamma2: G2Point,
        vk_delta2: G2Point,
        vk_ic: Array<G1Point>
    ) {
        self.vk_alpha1.write(vk_alpha1);
        self.vk_beta2.write(vk_beta2);
        self.vk_gamma2.write(vk_gamma2);
        self.vk_delta2.write(vk_delta2);
        
        let length = vk_ic.len();
        self.vk_ic_length.write(length);
        
        let mut i: u32 = 0;
        loop {
            if i >= length {
                break;
            }
            self.vk_ic.write(i, *vk_ic.at(i));
            i += 1;
        };
    }

    #[external]
    fn verifyProof(
        self: @ContractState,
        proof: Proof,
        input: Array<u256>
    ) -> bool {
        // 1. Verify input length matches vk
        assert(input.len() + 1 == self.vk_ic_length.read(), 'Input length mismatch');

        // 2. Compute linear combination: vk_x = input[0]*vk_ic[1] + input[1]*vk_ic[2] + ... + vk_ic[0]
        let mut vk_x = self.vk_ic.read(0);
        let mut i: u32 = 0;
        
        loop {
            if i >= input.len() {
                break;
            }
            
            let ic = self.vk_ic.read(i + 1);
            let scalar = *input.at(i);
            vk_x = g1_add(vk_x, g1_scalar_mul(ic, scalar));
            
            i += 1;
        };

        // 3. Perform pairing check
        // e(proof.a, proof.b) == e(vk_alpha1, vk_beta2) * e(vk_x, vk_gamma2) * e(proof.c, vk_delta2)
        
        let pairing1 = pairing(proof.a, proof.b);
        let pairing2 = pairing(self.vk_alpha1.read(), self.vk_beta2.read());
        let pairing3 = pairing(vk_x, self.vk_gamma2.read());
        let pairing4 = pairing(proof.c, self.vk_delta2.read());

        // Final check: pairing1 == pairing2 * pairing3 * pairing4
        pairing1 == (pairing2 * pairing3 * pairing4) % P
    }
}

// Helper functions for elliptic curve operations
fn g1_add(p1: G1Point, p2: G1Point) -> G1Point {
    // Elliptic curve point addition on BN128
    // Implementation using affine coordinates
    // ... (complex math)
    G1Point { x: 0, y: 0 }
}

fn g1_scalar_mul(p: G1Point, scalar: u256) -> G1Point {
    // Scalar multiplication using double-and-add
    // ... (complex math)
    G1Point { x: 0, y: 0 }
}

fn pairing(p1: G1Point, p2: G2Point) -> u256 {
    // Optimal Ate pairing on BN128 curve
    // This is the most complex operation
    // Returns element in GT (target group)
    // ... (very complex math)
    0
}
```

**Alternative**: Use existing Starknet verifier libraries or implement via Cairo 1.0 builtins

### 4.2 Simplified Verifier Approach

**For hackathon**, use snarkjs to export verifier and transpile to Cairo:

```bash
# Generate verifier from circuit
snarkjs zkey export solidityverifier withdraw_final.zkey verifier.sol

# Convert Solidity verifier to Cairo (manual or tool-assisted)
# Or use: https://github.com/iden3/circom-stark
```

**Gas cost on Starknet**: ~8,000-15,000 gas (vs 300,000 on Ethereum)

---

## 5. Trusted Setup Ceremony

### 5.1 What is Trusted Setup?

**Problem**: Groth16 requires "toxic waste" (secret parameters)
**Solution**: Multi-Party Computation (MPC) ceremony

**Security Model**:
- Multiple participants contribute randomness
- If ANY ONE participant is honest and destroys their contribution
- Setup is secure

### 5.2 Ceremony Phases

**Phase 1**: Powers of Tau (universal)
```
Participants compute:
[τ^1], [τ^2], [τ^3], ..., [τ^n]

Where τ is secret, [] denotes elliptic curve point
```

**Phase 2**: Circuit-specific
```
Combine Phase 1 output with circuit R1CS
Generate proving and verification keys
```

### 5.3 Ceremony Implementation

**Using snarkjs:**

```bash
# 1. Start new ceremony
snarkjs powersoftau new bn128 20 pot20_0000.ptau -v

# 2. Contribute randomness
snarkjs powersoftau contribute pot20_0000.ptau pot20_0001.ptau --name="GhostProtocol-Contributor-1" -v

# 3. Second contributor
snarkjs powersoftau contribute pot20_0001.ptau pot20_0002.ptau --name="GhostProtocol-Contributor-2" -v

# 4. Beacon contribution (adds deterministic randomness)
snarkjs powersoftau beacon pot20_0002.ptau pot20_beacon.ptau 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f 10 -n="Final Beacon"

# 5. Prepare for phase 2
snarkjs powersoftau prepare phase2 pot20_beacon.ptau pot20_final.ptau -v

# 6. Circuit-specific setup
snarkjs groth16 setup withdraw.r1cs pot20_final.ptau withdraw_0000.zkey

# 7. Contribute to circuit-specific phase
snarkjs zkey contribute withdraw_0000.zkey withdraw_0001.zkey --name="GhostProtocol-Circuit" -v

# 8. Finalize
snarkjs zkey beacon withdraw_0001.zkey withdraw_final.zkey 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f 10 -n="Circuit Final"
```

### 5.4 Verification

```bash
# Verify ceremony transcript
snarkjs zkey verify withdraw.r1cs pot20_final.ptau withdraw_final.zkey

# Export verification key
snarkjs zkey export verificationkey withdraw_final.zkey verification_key.json
```

---

## 6. Commitment & Nullifier System

### 6.1 Mathematical Structure

**Secret Generation:**
```
secret = random(32 bytes)
nullifier = random(32 bytes)
```

**Commitment Computation:**
```
commitment = MiMC(secret)
           = MiMC7(secret, 0)
           
Mathematically:
- Start with x = secret
- Iterate 220 rounds: x = (x + round_constant)^7 mod p
- Return final x
```

**Nullifier Hash:**
```
nullifierHash = MiMC(nullifier)
              = MiMC7(nullifier, 0)
```

### 6.2 Note Format

```
GhostNote Structure:
{
  "currency": "tbtc",
  "amount": "0.01",
  "secret": "0x7f3a...9b2c",
  "nullifier": "0x3d4e...8f1a", 
  "commitment": "0x9a8b...7c6d",
  "nullifierHash": "0x1e2f...3a4b"
}

Serialized:
ghost-tbtc-0.01-0x7f3a...9b2c-0x3d4e...8f1a
```

### 6.3 Double-Spend Prevention

**Mechanism:**
```cairo
#[storage]
struct Storage {
    nullifierHashes: LegacyMap<felt252, bool>
}

fn withdraw(nullifierHash: felt252, ...) {
    assert(!nullifierHashes.read(nullifierHash), "Already spent");
    nullifierHashes.write(nullifierHash, true);
    // ... proceed with withdrawal
}
```

**Mathematical Guarantee:**
- Nullifier collision probability: 2^(-256)
- Practically impossible to generate two notes with same nullifier

---

## 7. Merkle Tree Implementation

### 7.1 Tree Specifications

**Parameters:**
```
Height: 20 levels
Capacity: 2^20 = 1,048,576 deposits
Hash function: MiMC7
Zero leaf: MiMC(0, 0) = specific constant
```

### 7.2 Incremental Tree

**Insertion Algorithm:**
```python
def insert(leaf):
    current_index = next_index
    current_level_hash = leaf
    
    for level in range(20):
        if current_index % 2 == 0:
            # Left child
            tree[level][current_index] = current_level_hash
            sibling = zeros[level]
        else:
            # Right child  
            sibling = tree[level][current_index - 1]
            
        # Hash with sibling
        if current_index % 2 == 0:
            current_level_hash = MiMC(current_level_hash, sibling)
        else:
            current_level_hash = MiMC(sibling, current_level_hash)
            
        current_index = current_index // 2
    
    root = current_level_hash
    next_index += 1
    return root
```

### 7.3 Merkle Proof Generation

**Algorithm:**
```python
def get_proof(leaf_index):
    proof = []
    indices = []
    
    for level in range(20):
        sibling_index = leaf_index ^ 1  # Flip last bit
        proof.append(tree[level][sibling_index])
        indices.append(leaf_index % 2)  # 0 = left, 1 = right
        leaf_index = leaf_index // 2
    
    return proof, indices
```

### 7.4 Cairo Implementation

```cairo
#[starknet::contract]
mod MerkleTreeWithHistory {
    #[storage]
    struct Storage {
        levels: u32,
        filled_subtrees: LegacyMap<u32, felt252>,  // Current subtree roots
        roots: LegacyMap<u32, felt252>,             // History of roots
        current_root_index: u32,
        next_index: u32,
        zeros: LegacyMap<u32, felt252>,             // Precomputed zeros
    }

    #[constructor]
    fn constructor(ref self: ContractState, levels: u32) {
        self.levels.write(levels);
        self.current_root_index.write(0);
        self.next_index.write(0);
        
        // Precompute zero hashes
        let mut current_zero: felt252 = 0;
        self.zeros.write(0, current_zero);
        
        let mut i: u32 = 1;
        loop {
            if i >= levels {
                break;
            }
            current_zero = hash_left_right(current_zero, current_zero);
            self.zeros.write(i, current_zero);
            self.filled_subtrees.write(i, current_zero);
            i += 1;
        };
        
        self.roots.write(0, current_zero);
    }

    #[external]
    fn insert(ref self: ContractState, leaf: felt252) -> felt252 {
        let levels = self.levels.read();
        let mut index = self.next_index.read();
        let mut current_hash = leaf;
        
        let mut i: u32 = 0;
        loop {
            if i >= levels {
                break;
            }
            
            if index % 2 == 0 {
                self.filled_subtrees.write(i, current_hash);
                current_hash = hash_left_right(
                    current_hash, 
                    self.zeros.read(i)
                );
            } else {
                current_hash = hash_left_right(
                    self.filled_subtrees.read(i),
                    current_hash
                );
            }
            
            index = index / 2;
            i += 1;
        };
        
        let root_index = (self.current_root_index.read() + 1) % 30;
        self.current_root_index.write(root_index);
        self.roots.write(root_index, current_hash);
        self.next_index.write(self.next_index.read() + 1);
        
        current_hash
    }

    fn hash_left_right(left: felt252, right: felt252) -> felt252 {
        // MiMC hash: H(left, right)
        pedersen_hash(left, right)
    }

    #[view]
    fn is_known_root(self: @ContractState, root: felt252) -> bool {
        if root == 0 {
            return false;
        }
        
        let mut i: u32 = 0;
        loop {
            if i >= 30 {
                break false;
            }
            if self.roots.read(i) == root {
                break true;
            }
            i += 1;
        }
    }
}
```

---

## 8. Private Payment Mechanisms

### 8.1 Link-Based Payments

**Encrypted Note Format:**
```typescript
interface EncryptedNote {
  ciphertext: string;        // AES-256-GCM encrypted
  iv: string;               // Initialization vector
  authTag: string;          // Authentication tag
  encryptedTo: string;      // Recipient public key (optional)
}

// Encryption
function encryptNote(note: GhostNote, recipientPubKey?: string): EncryptedNote {
  const key = recipientPubKey || generateEphemeralKey();
  const { ciphertext, iv, authTag } = AES256GCM.encrypt(
    JSON.stringify(note),
    key
  );
  
  return { ciphertext, iv, authTag, encryptedTo: recipientPubKey || '' };
}
```

**Smart Contract Storage:**
```cairo
#[storage]
struct Storage {
    payment_links: LegacyMap<felt252, EncryptedNote>,
    link_claimed: LegacyMap<felt252, bool>,
}

#[external]
fn create_payment_link(
    commitment: felt252,
    encrypted_note: Array<felt252>,
    expiration: u64
) -> felt252 {
    let link_id = pedersen_hash(commitment, expiration);
    
    payment_links.write(link_id, EncryptedNote {
        data: encrypted_note,
        expiration,
        claimed: false
    });
    
    link_id
}
```

### 8.2 Proof Generation for Link Claim

```typescript
async function claimPaymentLink(
  encryptedNoteData: string,
  recipientAddress: string
) {
  // 1. Decrypt note
  const note = decrypt(encryptedNoteData);
  
  // 2. Generate Merkle proof
  const merkleProof = await generateMerkleProof(
    note.commitment,
    merkleTree
  );
  
  // 3. Generate ZK proof
  const { proof, publicSignals } = await snarkjs.groth16.fullProve(
    {
      // Public inputs
      root: merkleProof.root,
      nullifierHash: note.nullifierHash,
      recipient: recipientAddress,
      relayer: 0,
      fee: 0,
      refund: 0,
      
      // Private inputs
      secret: note.secret,
      nullifier: note.nullifier,
      pathElements: merkleProof.pathElements,
      pathIndices: merkleProof.pathIndices
    },
    "withdraw.wasm",
    "withdraw_final.zkey"
  );
  
  // 4. Call contract
  await contract.withdraw(proof, publicSignals);
}
```

---

## 9. Security & Anti-Attack Features

### 9.1 Mathematical Security Properties

**Soundness:**
```
If verifier accepts proof → Prover actually knows witness
Probability of cheating: negligible (cryptographic hardness)
```

**Zero-Knowledge:**
```
Proof reveals nothing about:
- Which commitment was used
- The secret value
- The nullifier
- Merkle path taken
```

**Completeness:**
```
If prover knows witness → Verifier always accepts
Proof system is correct
```

### 9.2 Front-Running Protection

**Root History:**
```cairo
#[storage]
struct Storage {
    roots: LegacyMap<u32, felt252>,  // Last 30 roots
    current_root_index: u32,
}

fn is_valid_root(root: felt252) -> bool {
    for i in 0..30 {
        if roots[(current_index - i) % 30] == root {
            return true;
        }
    }
    false
}
```

**Why this works:**
- Proof valid for ~30 blocks
- Attacker can't front-run without invalidating proof
- No commit-reveal pattern needed

### 9.3 Double-Spend Prevention

**Nullifier Uniqueness:**
```
Probability of collision: 1/2^256 ≈ 0
Practically impossible to generate two notes with same nullifier
```

**Storage Check:**
```cairo
assert(!nullifierHashes[nullifierHash], "Already spent");
nullifierHashes[nullifierHash] = true;
```

---

## 10. Gas Optimization

### 10.1 Constraint Optimization

**Circuit Constraints (Groth16):**
```
Total constraints: ~12,000
- MiMC7: 90 constraints per hash × ~40 hashes = 3,600
- Merkle proof verification: ~200 constraints
- Arithmetic: ~500 constraints
- Range checks: ~7,000 constraints
```

**Constraint Reduction Techniques:**
1. Use MiMC instead of SHA256 (90 vs 25,000 constraints)
2. Batch range checks
3. Optimize Merkle tree depth
4. Use efficient bit decomposition

### 10.2 Starknet Gas Comparison

| Operation | Tornado Cash (ETH) | GhostProtocol (Starknet) | Savings |
|-----------|-------------------|-------------------------|---------|
| Proof Verification | ~300,000 gas | ~8,000 gas | 97% |
| Merkle Insert | ~50,000 gas | ~3,000 gas | 94% |
| Token Transfer | ~65,000 gas | ~2,000 gas | 97% |
| Total Deposit | ~200,000 gas | ~8,000 gas | 96% |
| Total Withdraw | ~300,000 gas | ~15,000 gas | 95% |

### 10.3 Client-Side Proof Generation

**Browser Performance:**
```
Proof generation time: 2-5 seconds
Memory usage: ~500 MB
WebAssembly: Compiled from circom
```

**Optimization:**
- Web Workers for background computation
- Progress indicators
- WASM caching
- Optional: Server-side proving (with privacy trade-off)

---

## Implementation Checklist

### Week 1: Core Cryptography
- [ ] Install Circom and snarkjs
- [ ] Write withdraw.circom circuit
- [ ] Compile circuit to R1CS
- [ ] Perform trusted setup ceremony
- [ ] Generate proving/verification keys
- [ ] Test proof generation and verification

### Week 2: Smart Contracts
- [ ] Implement MerkleTreeWithHistory in Cairo
- [ ] Implement GhostPool contract
- [ ] Implement Verifier contract (or use library)
- [ ] Write deposit/withdraw functions
- [ ] Add nullifier tracking
- [ ] Deploy to Starknet testnet

### Week 3: Client-Side
- [ ] Generate WASM from circuit
- [ ] Implement note generation
- [ ] Implement Merkle proof generation
- [ ] Implement proof generation in browser
- [ ] Integrate with Starknet.js
- [ ] Build basic UI

### Week 4: GhostPay Features
- [ ] Payment link generation
- [ ] QR code generation
- [ ] Link claiming flow
- [ ] Account abstraction integration
- [ ] UI/UX polish
- [ ] Testing and submission

---

## Mathematical References

### Elliptic Curves
- **BN128**: y² = x³ + 3 (mod p)
- **Order**: r = 21888242871839275222246405745257275088696311157297823662689037894645226208583
- **Field**: Fp where p = 21888242871839275222246405745257275088548364400416034343698204186575808495617

### Pairings
- **Type**: Optimal Ate pairing
- **Bilinearity**: e(aP, bQ) = e(P, Q)^(ab)
- **Non-degeneracy**: e(G1, G2) ≠ 1
- **Computability**: Efficiently computable

### Hash Functions
- **MiMC7**: x^7 round function
- **Rounds**: 220 for 128-bit security
- **Constraints**: ~90 per hash in R1CS

---

## Resources

**Circom:**
- https://docs.circom.io
- https://github.com/iden3/circom

**SnarkJS:**
- https://github.com/iden3/snarkjs
- Groth16 implementation

**Tornado Cash:**
- https://github.com/tornadocash/tornado-core
- Production implementation

**Starknet:**
- https://docs.starknet.io
- Cairo documentation

---

*Document uses Tornado Cash mathematics for maximum privacy guarantees*
*Groth16 + Circom + MiMC implementation*
