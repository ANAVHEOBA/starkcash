//! Merkle Tree Storage
//!
//! Handles storage of tree nodes for proof generation.

use std::collections::HashMap;

/// Storage interface for the Merkle tree
#[derive(Debug, Default, Clone)]
pub struct MerkleStorage {
    /// Maps (level, index) -> hash
    nodes: HashMap<(usize, u32), [u8; 32]>,
}

impl MerkleStorage {
    pub fn new() -> Self {
        Self {
            nodes: HashMap::new(),
        }
    }

    /// Insert a node hash at a specific position
    pub fn insert(&mut self, level: usize, index: u32, hash: [u8; 32]) {
        self.nodes.insert((level, index), hash);
    }

    /// Get a node hash if it exists
    pub fn get(&self, level: usize, index: u32) -> Option<[u8; 32]> {
        self.nodes.get(&(level, index)).copied()
    }
}
