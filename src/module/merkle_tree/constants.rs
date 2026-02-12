//! Merkle Tree Constants
//!
//! Defines tree parameters and zero values.

use crate::module::cryptography::poseidon_hash;
use std::sync::OnceLock;

/// Tree depth (20 levels = 1M leaves)
pub const LEVELS: usize = 20;

/// Tree capacity
pub const CAPACITY: usize = 1 << LEVELS;

/// Number of roots to keep in history
pub const ROOT_HISTORY_SIZE: usize = 30;

/// Cached zero values for all levels
static ZEROS: OnceLock<Vec<[u8; 32]>> = OnceLock::new();

/// Get the zero value for a specific level.
/// Level 0 is the leaf level.
/// Level 20 is the root level.
pub fn get_zero(level: usize) -> [u8; 32] {
    let zeros = ZEROS.get_or_init(|| {
        let mut z = vec![[0u8; 32]; LEVELS + 1];
        
        // Initial zero value (Keccak256("tornado")) used by Tornado Cash
        // We use the same constant for compatibility and security
        let mut current = [
            0x2f, 0xe5, 0x4c, 0x60, 0xd3, 0xac, 0xab, 0xf3, 0x34, 0x3a, 0x35, 0xb6, 0xeb, 0xa7,
            0x5f, 0xdc, 0x3c, 0x44, 0x64, 0x83, 0x16, 0x82, 0x33, 0xf2, 0xc5, 0xf7, 0x43, 0x58,
            0xa9, 0xe6, 0x4e, 0x52,
        ];
        
        z[0] = current;

        for i in 0..LEVELS {
            current = poseidon_hash(&current, &current);
            z[i + 1] = current;
        }
        
        z
    });

    if level >= zeros.len() {
        panic!("Level {} out of bounds", level);
    }
    zeros[level]
}

/// Get the hash of an empty tree (root of a tree with all zeros)
pub fn empty_tree_root() -> [u8; 32] {
    get_zero(LEVELS)
}
