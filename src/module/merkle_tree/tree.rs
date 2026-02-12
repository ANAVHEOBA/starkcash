//! Incremental Merkle Tree Logic
//!
//! Core implementation of the append-only tree.

use crate::module::cryptography::poseidon_hash;
use super::constants::{get_zero, empty_tree_root, LEVELS, ROOT_HISTORY_SIZE};
use super::storage::MerkleStorage;
use super::proof::MerkleProof;

/// Incremental Merkle Tree
#[derive(Debug)]
pub struct IncrementalMerkleTree {
    /// Index of the next leaf to be inserted
    pub next_index: u32,

    /// Filled subtrees (left siblings of the current frontier)
    pub filled_subtrees: Vec<[u8; 32]>,

    /// History of roots
    pub roots: Vec<[u8; 32]>,
    pub current_root_index: usize,

    /// Full node storage for proof generation
    pub storage: MerkleStorage,
}

impl IncrementalMerkleTree {
    /// Create a new empty tree
    pub fn new() -> Self {
        let mut filled_subtrees = vec![[0u8; 32]; LEVELS];
        
        // Initialize filled_subtrees with zeros
        for i in 0..LEVELS {
            filled_subtrees[i] = get_zero(i);
        }

        let mut tree = Self {
            next_index: 0,
            filled_subtrees,
            roots: vec![[0u8; 32]; ROOT_HISTORY_SIZE],
            current_root_index: 0,
            storage: MerkleStorage::new(),
        };

        // Initialize root history with empty tree root
        let root = empty_tree_root();
        tree.roots[0] = root;
        
        tree
    }

    /// Insert a leaf commitment into the tree
    pub fn insert(&mut self, leaf: [u8; 32]) -> [u8; 32] {
        if self.next_index >= (1u32 << LEVELS) {
            panic!("Merkle tree is full");
        }

        let mut current_index = self.next_index;
        let mut current_hash = leaf;
        
        // Store leaf
        self.storage.insert(0, self.next_index, leaf);

        for i in 0..LEVELS {
            let left;
            let right;

            if current_index % 2 == 0 {
                // We are left child
                self.filled_subtrees[i] = current_hash;
                left = current_hash;
                right = get_zero(i);
            } else {
                // We are right child - left is in filled_subtrees
                left = self.filled_subtrees[i];
                right = current_hash;
            }

            // Store siblings for proof generation
            self.storage.insert(i, (self.next_index >> i) & !1, left); // Left sibling
            if current_index % 2 == 0 {
                 // If we are left, right is zero, implicitly stored or handled by get_proof
            } else {
                 self.storage.insert(i, (self.next_index >> i) | 1, right); // Right sibling
            }

            current_hash = poseidon_hash(&left, &right);
            
            // Store parent
            self.storage.insert(i + 1, self.next_index >> (i + 1), current_hash);
            
            current_index /= 2;
        }

        let new_root = current_hash;
        
        self.current_root_index = (self.current_root_index + 1) % ROOT_HISTORY_SIZE;
        self.roots[self.current_root_index] = new_root;
        self.next_index += 1;

        new_root
    }

    /// Get current root
    pub fn root(&self) -> [u8; 32] {
        self.roots[self.current_root_index]
    }

    /// Check if a root exists in history
    pub fn is_known_root(&self, root: [u8; 32]) -> bool {
        if root == [0u8; 32] {
            return false;
        }
        self.roots.contains(&root)
    }

    /// Generate Merkle prrof for a leaf at index
    pub fn get_proof(&self, index: u32) -> MerkleProof {
        if index >= self.next_index {
            panic!("Leaf index out of bounds");
        }

        let mut path_elements = Vec::with_capacity(LEVELS);
        let mut path_indices = Vec::with_capacity(LEVELS);
        
        let mut curr = index;
        
        for i in 0..LEVELS {
            path_indices.push((curr % 2) as u8);
            
            let sibling_index = curr ^ 1;
            let sibling = self.storage.get(i, sibling_index).unwrap_or_else(|| get_zero(i));
            
            path_elements.push(sibling);
            curr /= 2;
        }

        MerkleProof {
            root: self.root(),
            path_elements,
            path_indices,
        }
    }
}
