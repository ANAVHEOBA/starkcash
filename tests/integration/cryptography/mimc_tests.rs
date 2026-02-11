//! Integration tests for MiMC hash function
//!
//! Tests MiMC7 implementation: x = (x + k)^7 mod p

#[test]
fn test_mimc7_hash_basic() {
    // Two 32-byte inputs should produce hash
    let left = [0x01u8; 32];
    let right = [0x02u8; 32];

    let hash = starkcash::cryptography::mimc7_hash(&left, &right);

    assert!(!hash.is_empty(), "Hash should not be empty");
    assert_eq!(hash.len(), 32, "Hash should be 32 bytes");
}

#[test]
fn test_mimc7_is_deterministic() {
    // Same inputs should produce same hash
    let left = [0xabu8; 32];
    let right = [0xbcu8; 32];

    let hash1 = starkcash::cryptography::mimc7_hash(&left, &right);
    let hash2 = starkcash::cryptography::mimc7_hash(&left, &right);
    let hash3 = starkcash::cryptography::mimc7_hash(&left, &right);

    assert_eq!(hash1, hash2, "MiMC should be deterministic");
    assert_eq!(hash2, hash3, "MiMC should be deterministic");
}

#[test]
fn test_mimc7_different_inputs_different_outputs() {
    // Different inputs should produce different hashes
    let hash1 = starkcash::cryptography::mimc7_hash(&[0x01u8; 32], &[0x02u8; 32]);
    let hash2 = starkcash::cryptography::mimc7_hash(&[0x01u8; 32], &[0x03u8; 32]);
    let hash3 = starkcash::cryptography::mimc7_hash(&[0x02u8; 32], &[0x02u8; 32]);

    assert_ne!(
        hash1, hash2,
        "Different inputs should produce different hashes"
    );
    assert_ne!(
        hash2, hash3,
        "Different inputs should produce different hashes"
    );
    assert_ne!(
        hash1, hash3,
        "Different inputs should produce different hashes"
    );
}

#[test]
fn test_mimc7_collision_resistance() {
    // Generate many hashes and check for collisions
    let mut hashes = vec![];

    for i in 0u8..50 {
        for j in 0u8..50 {
            let left = [i; 32];
            let right = [j; 32];
            let hash = starkcash::cryptography::mimc7_hash(&left, &right);
            hashes.push(hash);
        }
    }

    // All 2500 hashes should be unique
    let original_count = hashes.len();
    hashes.sort();
    hashes.dedup();

    assert_eq!(
        hashes.len(),
        original_count,
        "Found collision in MiMC7 hash after {} iterations",
        original_count
    );
}

#[test]
fn test_mimc7_zero_inputs() {
    // Hash of zeros should not be zero
    let zero = [0x00u8; 32];

    let hash = starkcash::cryptography::mimc7_hash(&zero, &zero);

    assert_ne!(
        hash.to_vec(),
        zero.to_vec(),
        "Hash of zeros should not be zero (preimage resistance)"
    );
}

#[test]
fn test_mimc7_large_inputs() {
    // Should handle max values without overflow
    let max = [0xffu8; 32];

    let hash = starkcash::cryptography::mimc7_hash(&max, &max);

    assert!(!hash.is_empty(), "Should handle max values");
}

#[test]
fn test_mimc7_performance() {
    use std::time::Instant;

    // Should be reasonably fast
    let left = [0x12u8; 32];
    let right = [0x34u8; 32];

    let start = Instant::now();
    for _ in 0..1000 {
        let _ = starkcash::cryptography::mimc7_hash(&left, &right);
    }
    let duration = start.elapsed();

    println!("1000 MiMC7 hashes took: {:?}", duration);
    assert!(
        duration.as_millis() < 5000,
        "MiMC7 too slow: {:?}",
        duration
    );
}

#[test]
fn test_mimc7_order_independence() {
    // MiMC should be order-dependent for security
    let a = [0x01u8; 32];
    let b = [0x02u8; 32];

    let hash_ab = starkcash::cryptography::mimc7_hash(&a, &b);
    let hash_ba = starkcash::cryptography::mimc7_hash(&b, &a);

    assert_ne!(
        hash_ab, hash_ba,
        "MiMC7 should be order-dependent for security"
    );
}

#[test]
#[should_panic(expected = "Input must be 32 bytes")]
fn test_mimc7_with_short_left_input() {
    let left = [0x01u8; 16];
    let right = [0x02u8; 32];
    let _ = starkcash::cryptography::mimc7_hash(&left, &right);
}

#[test]
#[should_panic(expected = "Input must be 32 bytes")]
fn test_mimc7_with_short_right_input() {
    let left = [0x01u8; 32];
    let right = [0x02u8; 16];
    let _ = starkcash::cryptography::mimc7_hash(&left, &right);
}

#[test]
fn test_mimc7_with_empty_left_input() {
    let left: &[u8] = &[];
    let right = [0x02u8; 32];

    let result = std::panic::catch_unwind(|| starkcash::cryptography::mimc7_hash(left, &right));
    assert!(result.is_err(), "Empty input should panic");
}

#[test]
fn test_mimc7_with_empty_right_input() {
    let left = [0x01u8; 32];
    let right: &[u8] = &[];

    let result = std::panic::catch_unwind(|| starkcash::cryptography::mimc7_hash(&left, right));
    assert!(result.is_err(), "Empty input should panic");
}

#[test]
fn test_mimc7_with_exactly_32_bytes() {
    // Edge case: exactly 32 bytes
    let left = [0xabu8; 32];
    let right = [0xcdu8; 32];

    let hash = starkcash::cryptography::mimc7_hash(&left, &right);
    assert_eq!(hash.len(), 32);
}

#[test]
fn test_mimc7_all_zeros_vs_all_ones() {
    // Different inputs should give different outputs
    let zeros = [0x00u8; 32];
    let ones = [0xffu8; 32];

    let hash_zeros = starkcash::cryptography::mimc7_hash(&zeros, &zeros);
    let hash_ones = starkcash::cryptography::mimc7_hash(&ones, &ones);

    assert_ne!(hash_zeros, hash_ones, "Different inputs should differ");
}

#[test]
fn test_mimc7_chaining() {
    // Hash chain: H(H(a,b), c)
    let a = [0x01u8; 32];
    let b = [0x02u8; 32];
    let c = [0x03u8; 32];

    let hash_ab = starkcash::cryptography::mimc7_hash(&a, &b);
    let hash_abc = starkcash::cryptography::mimc7_hash(&hash_ab, &c);

    // Result should be different from just H(a,c)
    let hash_ac = starkcash::cryptography::mimc7_hash(&a, &c);

    assert_ne!(hash_abc, hash_ac, "Chained hash should differ");
}

#[test]
fn test_mimc7_consistency_across_calls() {
    // Multiple calls with same input should be consistent
    let left = [0xdeu8, 0xadu8, 0xbeu8, 0xefu8]; // 4 bytes only, need to fill
    let mut full_left = [0u8; 32];
    full_left[0..4].copy_from_slice(&left);
    let right = [0xcau8, 0xfeu8, 0xbau8, 0xbeu8];
    let mut full_right = [0u8; 32];
    full_right[0..4].copy_from_slice(&right);

    let hashes: Vec<_> = (0..10)
        .map(|_| starkcash::cryptography::mimc7_hash(&full_left, &full_right))
        .collect();

    // All should be identical
    for i in 1..hashes.len() {
        assert_eq!(hashes[0], hashes[i], "Inconsistent hash at index {}", i);
    }
}
