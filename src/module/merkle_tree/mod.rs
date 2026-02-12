//! Merkle Tree Module
//!
//! Implements an incremental Merkle tree for the privacy set.
//!
//! Submodules:
//! - `constants`: Tree parameters and zero values
//! - `storage`: Backend storage for tree nodes
//! - `proof`: Merkle proof generation and verification
//! - `tree`: Core incremental tree logic

pub mod constants;
pub mod proof;
pub mod storage;
pub mod tree;

pub use constants::{LEVELS, ROOT_HISTORY_SIZE, CAPACITY};
pub use proof::MerkleProof;
pub use storage::MerkleStorage;
pub use tree::IncrementalMerkleTree;
