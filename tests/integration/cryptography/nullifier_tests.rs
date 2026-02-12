//! Integration tests for nullifier generation
//!
//! Tests the nullifier scheme: nullifierHash = MiMC(nullifier)
//! Critical for preventing double-spends

#[test]
fn test_random_nullifier() {
    // Should generate random nullifier
    let nullifier = starkcash::cryptography::random_nullifier();

    assert!(!nullifier.is_empty(), "Nullifier should not be empty");
    assert_eq!(nullifier.len(), 32, "Nullifier should be 32 bytes");
}

#[test]
fn test_nullifier_hash_generation() {
    // Should generate hash from nullifier
    let nullifier = [0xcdu8; 32];

    let nullifier_hash = starkcash::cryptography::generate_nullifier_hash(&nullifier);

    assert!(
        !nullifier_hash.is_empty(),
        "Nullifier hash should not be empty"
    );
    assert_eq!(
        nullifier_hash.len(),
        32,
        "Nullifier hash should be 32 bytes"
    );
}

#[test]
fn test_nullifier_hash_deterministic() {
    // Same nullifier should produce same hash
    let nullifier = [0x12u8; 32];

    let hash1 = starkcash::cryptography::generate_nullifier_hash(&nullifier);
    let hash2 = starkcash::cryptography::generate_nullifier_hash(&nullifier);

    assert_eq!(hash1, hash2, "Nullifier hash should be deterministic");
}

#[test]
fn test_nullifier_hash_different_inputs() {
    // Different nullifiers should produce different hashes
    let nullifier1 = [0x01u8; 32];
    let nullifier2 = [0x02u8; 32];

    let hash1 = starkcash::cryptography::generate_nullifier_hash(&nullifier1);
    let hash2 = starkcash::cryptography::generate_nullifier_hash(&nullifier2);

    assert_ne!(
        hash1, hash2,
        "Different nullifiers should have different hashes"
    );
}

#[test]
fn test_empty_spent_set() {
    // Empty spent set should allow any nullifier
    let nullifier_hash = [0xabu8; 32];
    let spent_set: Vec<[u8; 32]> = vec![];

    assert!(
        starkcash::cryptography::is_nullifier_unique(&nullifier_hash, &spent_set),
        "Any nullifier should be unique in empty set"
    );
}

#[test]
fn test_nullifier_uniqueness_check() {
    // Should detect if nullifier is already spent
    let nullifier_hash = [0xdeu8; 32];
    let spent_nullifiers: Vec<[u8; 32]> = vec![];

    let is_unspent =
        starkcash::cryptography::is_nullifier_unique(&nullifier_hash, &spent_nullifiers);
    assert!(is_unspent, "New nullifier should be unique");
}

#[test]
fn test_nullifier_spent_detection() {
    // Should detect spent nullifier
    let nullifier_hash = [0xdeu8; 32];
    let spent_nullifiers = vec![[0xdeu8; 32]];

    let is_unique =
        starkcash::cryptography::is_nullifier_unique(&nullifier_hash, &spent_nullifiers);
    assert!(!is_unique, "Spent nullifier should not be unique");
}

#[test]
fn test_mark_nullifier_spent() {
    // Should add nullifier to spent set
    let nullifier_hash = [0xabu8; 32];
    let mut spent_set: Vec<[u8; 32]> = vec![];

    starkcash::cryptography::mark_nullifier_spent(nullifier_hash, &mut spent_set);

    assert!(
        spent_set.contains(&nullifier_hash),
        "Nullifier should be in spent set"
    );
}

#[test]
fn test_no_duplicate_spent_markers() {
    // Should not add duplicate entries
    let nullifier_hash = [0xabu8; 32];
    let mut spent_set: Vec<[u8; 32]> = vec![];

    starkcash::cryptography::mark_nullifier_spent(nullifier_hash, &mut spent_set);
    starkcash::cryptography::mark_nullifier_spent(nullifier_hash, &mut spent_set);

    assert_eq!(spent_set.len(), 1, "Should not have duplicates");
}

#[test]
fn test_large_spent_set_performance() {
    use std::time::Instant;

    // Create large spent set
    let spent_set: Vec<[u8; 32]> = (0..1000u16)
        .map(|i| {
            let bytes = i.to_le_bytes();
            let mut hash = [0u8; 32];
            hash[0..2].copy_from_slice(&bytes);
            hash
        })
        .collect();

    let nullifier_hash = [0xffu8; 32];

    let start = Instant::now();
    let _ = starkcash::cryptography::is_nullifier_unique(&nullifier_hash, &spent_set);
    let duration = start.elapsed();

    assert!(duration.as_millis() < 100, "Uniqueness check too slow");
}

#[test]
fn test_nullifier_collision_resistance() {
    // Generate many random nullifiers (should be collision resistant by probability)
    let mut nullifiers = vec![];

    for _ in 0..100 {
        let nullifier = starkcash::cryptography::random_nullifier();
        nullifiers.push(nullifier);
    }

    // All should be unique
    let unique_count = nullifiers.len();
    nullifiers.sort();
    nullifiers.dedup();

    assert_eq!(
        nullifiers.len(),
        unique_count,
        "Found collision in random nullifier generation"
    );
}
