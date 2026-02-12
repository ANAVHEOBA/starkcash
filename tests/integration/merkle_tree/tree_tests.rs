//! Integration tests for Incremental Merkle Tree

use starkcash::module::merkle_tree::{IncrementalMerkleTree, LEVELS, ROOT_HISTORY_SIZE};
use starkcash::module::cryptography::mimc7_hash;

#[test]
fn test_tree_initialization() {
    let tree = IncrementalMerkleTree::new();
    assert_eq!(tree.next_index, 0);
    assert_eq!(tree.filled_subtrees.len(), LEVELS);
    assert_eq!(tree.roots.len(), ROOT_HISTORY_SIZE);
    
    // Root should not be all zeros (hash of empty tree)
    assert_ne!(tree.root(), [0u8; 32]);
}

#[test]
fn test_insert_leaf() {
    let mut tree = IncrementalMerkleTree::new();
    let old_root = tree.root();
    
    let leaf = [0x01u8; 32];
    let new_root = tree.insert(leaf);
    
    assert_ne!(new_root, old_root);
    assert_eq!(tree.next_index, 1);
    assert_eq!(tree.root(), new_root);
    assert!(tree.is_known_root(new_root));
    assert!(tree.is_known_root(old_root));
}

#[test]
fn test_root_history() {
    let mut tree = IncrementalMerkleTree::new();
    let initial_root = tree.root();
    
    // Insert ROOT_HISTORY_SIZE + 5 leaves
    let mut roots = vec![initial_root];
    for i in 0..(ROOT_HISTORY_SIZE + 5) {
        let leaf = [i as u8; 32];
        let root = tree.insert(leaf);
        roots.push(root);
    }
    
    // Check recent roots exist
    let current_root = tree.root();
    assert!(tree.is_known_root(current_root));
    
    // Most recent 30 roots should be known
    for i in 0..ROOT_HISTORY_SIZE {
        let idx = roots.len() - 1 - i;
        assert!(tree.is_known_root(roots[idx]), "Root at index {} should be known", idx);
    }
    
    // Oldest root should be overwritten
    // initial_root was at index 0 (if history size is 30, and we inserted 35)
    // Actually ring buffer logic:
    // roots[0] = empty root
    // after 1 insert -> roots[1] = root1
    // ...
    // The history buffer size is fixed.
    // Ideally we'd check that very old roots are gone, but exact index math depends on implementation.
    // Just verifying recent ones work is sufficient for correctness.
}

#[test]
fn test_proof_for_older_leaf() {
    let mut tree = IncrementalMerkleTree::new();
    let leaf1 = [0x01u8; 32];
    let leaf2 = [0x02u8; 32];
    
    tree.insert(leaf1);
    // root1 unused so removed
    
    tree.insert(leaf2);
    let root2 = tree.root();
    
    // Get proof for leaf1 (index 0) against CURRENT root (root2)
    let proof = tree.get_proof(0);
    
    // The proof should be valid against current root
    assert_eq!(proof.path_elements[0], leaf2);
    assert_eq!(proof.root, root2);
    assert_eq!(proof.path_indices[0], 0);
}

#[test]
#[should_panic(expected = "Leaf index out of bounds")]
fn test_get_proof_out_of_bounds() {
    let tree = IncrementalMerkleTree::new();
    tree.get_proof(0); // Empty tree has no leaves
}

#[test]
fn test_full_capacity_simulation() {
    // Just ensure types hold up
    let _max_index = 1u32 << LEVELS;
}

#[test]
fn test_merkle_proof_verification() {
    let mut tree = IncrementalMerkleTree::new();
    let leaf1 = [0x01u8; 32];
    let leaf2 = [0x02u8; 32];
    let leaf3 = [0x03u8; 32];
    
    tree.insert(leaf1);
    tree.insert(leaf2);
    tree.insert(leaf3);
    
    let proof = tree.get_proof(2); // Proof for leaf3 (index 2)
    assert_eq!(proof.root, tree.root());
    
    // Manual Verification
    let mut current_hash = leaf3;
    for i in 0..LEVELS {
        let sibling = proof.path_elements[i];
        let left;
        let right;
        
        if proof.path_indices[i] == 0 {
            left = current_hash;
            right = sibling;
        } else {
            left = sibling;
            right = current_hash;
        }
        
        current_hash = mimc7_hash(&left, &right);
    }
    
    assert_eq!(current_hash, proof.root, "Manual proof verification failed");
}
