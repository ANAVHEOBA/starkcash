//! Cryptography Module
//!
//! Core cryptographic primitives for StarkCash:
//! - Poseidon hash function
//! - Commitment scheme
//! - Nullifier generation
//! - ZK proof generation/verification
//! - Utility functions

pub mod commitment;
pub mod mimc;
pub mod poseidon;
pub mod nullifier;
pub mod proof;
pub mod utils;

// Re-export main types
pub use commitment::{
    batch_generate_commitments, generate_commitment, random_commitment, verify_commitment,
    Commitment,
};
pub use mimc::{mimc7_hash, mimc7_hash_single};
pub use poseidon::{poseidon_hash, poseidon_hash_single};
pub use nullifier::{
    generate_nullifier_hash, is_nullifier_unique, mark_nullifier_spent, random_nullifier,
    Nullifier, NullifierHash,
};
pub use proof::{generate_proof, verify_proof, Proof, PublicInputs, Witness};
pub use utils::{
    bytes_to_hex, bytes_to_hex_with_prefix, concat_bytes, constant_time_compare, hex_to_bytes,
    is_valid_bytes32, pad_to_32_bytes, random_bytes32, split_bytes, xor_bytes,
};
