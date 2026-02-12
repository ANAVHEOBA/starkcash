//! Merkle Proof
//!
//! Structures and logic for Merkle proofs.

/// A Merkle proof for a leaf inclusion
#[derive(Debug, Clone, PartialEq)]
pub struct MerkleProof {
    /// The root this proof validates against
    pub root: [u8; 32],
    /// Sibling hashes along the path
    pub path_elements: Vec<[u8; 32]>,
    /// Path indices (0 for left, 1 for right)
    pub path_indices: Vec<u8>,
}
