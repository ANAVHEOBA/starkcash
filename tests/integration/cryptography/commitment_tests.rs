//! Integration tests for commitment generation
//!
//! Tests the core commitment scheme: commitment = MiMC(secret)

#[test]
fn test_commitment_generation_with_valid_secret() {
    // Test that a valid 32-byte secret generates a commitment
    let secret = [
        0x7fu8, 0x3a, 0x92, 0x1b, 0x8c, 0x4d, 0x5e, 0x6f, 0x71, 0x82, 0x93, 0xa4, 0xb5, 0xc6, 0xd7,
        0xe8, 0xf9, 0x0a, 0x1b, 0x2c, 0x3d, 0x4e, 0x5f, 0x60, 0x71, 0x82, 0x93, 0xa4, 0xb5, 0xc6,
        0xd7, 0xe8,
    ];

    let nullifier = [0xabu8; 32];
    let commitment = starkcash::cryptography::generate_commitment(&secret, &nullifier);

    assert!(!commitment.is_empty(), "Commitment should not be empty");
    assert_eq!(commitment.len(), 32, "Commitment should be 32 bytes");
}

#[test]
fn test_commitment_is_deterministic() {
    // Same secret should produce same commitment
    let secret = [0xabu8; 32];

    let nullifier = [0xcdu8; 32];
    let commitment1 = starkcash::cryptography::generate_commitment(&secret, &nullifier);
    let commitment2 = starkcash::cryptography::generate_commitment(&secret, &nullifier);

    assert_eq!(
        commitment1, commitment2,
        "Same secret must produce same commitment"
    );
}

#[test]
fn test_different_secrets_produce_different_commitments() {
    // Different secrets should produce different commitments (collision resistance)
    let secret1 = [0x01u8; 32];
    let secret2 = [0x02u8; 32];

    let nullifier = [0x03u8; 32];
    let commitment1 = starkcash::cryptography::generate_commitment(&secret1, &nullifier);
    let commitment2 = starkcash::cryptography::generate_commitment(&secret2, &nullifier);

    assert_ne!(
        commitment1, commitment2,
        "Different secrets must produce different commitments"
    );
}

#[test]
fn test_commitment_hides_secret() {
    // Commitment should not reveal the secret
    let secret = [
        0x12u8, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0xde, 0xf0, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
        0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x00, 0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
        0xde, 0xf0,
    ];

    let nullifier = [0x00u8; 32];
    let commitment = starkcash::cryptography::generate_commitment(&secret, &nullifier);

    assert_ne!(
        commitment.to_vec(),
        secret.to_vec(),
        "Commitment must not equal secret"
    );
}

#[test]
#[should_panic(expected = "Secret must be 32 bytes")]
fn test_commitment_with_short_secret_should_panic() {
    // Secret shorter than 32 bytes should panic
    let short_secret = [0x01u8; 16];
    let nullifier = [0u8; 32];
    let _ = starkcash::cryptography::generate_commitment(&short_secret, &nullifier);
}

#[test]
#[should_panic(expected = "Secret must be 32 bytes")]
fn test_commitment_with_long_secret_should_panic() {
    // Secret longer than 32 bytes should panic
    let long_secret = [0x01u8; 64];
    let nullifier = [0u8; 32];
    let _ = starkcash::cryptography::generate_commitment(&long_secret, &nullifier);
}

#[test]
fn test_commitment_with_empty_secret_should_panic() {
    // Empty secret should panic
    let empty_secret: &[u8] = &[];
    let nullifier = [0u8; 32];
    let result =
        std::panic::catch_unwind(|| starkcash::cryptography::generate_commitment(empty_secret, &nullifier));
    assert!(result.is_err(), "Empty secret should panic");
}

#[test]
fn test_commitment_with_exactly_32_bytes() {
    // Edge case: exactly 32 bytes should work
    let secret = [0xffu8; 32];
    let nullifier = [0x00u8; 32];
    let commitment = starkcash::cryptography::generate_commitment(&secret, &nullifier);

    assert_eq!(commitment.len(), 32);
}

#[test]
fn test_commitment_with_all_zeros() {
    // Edge case: all zero secret
    let secret = [0x00u8; 32];
    let nullifier = [0x00u8; 32];
    let commitment = starkcash::cryptography::generate_commitment(&secret, &nullifier);

    assert!(
        !commitment.iter().all(|&b| b == 0),
        "Commitment of zero should not be zero"
    );
}

#[test]
fn test_commitment_with_all_ones() {
    // Edge case: all 0xff secret
    let secret = [0xffu8; 32];
    let nullifier = [0x00u8; 32];
    let commitment = starkcash::cryptography::generate_commitment(&secret, &nullifier);

    assert_eq!(commitment.len(), 32);
}

#[test]
fn test_commitment_collision_resistance() {
    // Generate many commitments and check for collisions
    let mut commitments = vec![];

    for i in 0u8..100 {
        let secret = [i; 32];
        let nullifier = [i; 32];
        let commitment = starkcash::cryptography::generate_commitment(&secret, &nullifier);
        commitments.push(commitment);
    }

    // Check all are unique
    let unique_count = commitments.len();
    commitments.sort();
    commitments.dedup();

    assert_eq!(
        commitments.len(),
        unique_count,
        "Found collision in commitment generation"
    );
}

#[test]
fn test_commitment_performance() {
    use std::time::Instant;

    // Should be fast enough for real-world use
    let secret = [0x99u8; 32];
    let nullifier = [0x99u8; 32];
    let start = Instant::now();

    for _ in 0..100 {
        let _ = starkcash::cryptography::generate_commitment(&secret, &nullifier);
    }

    let duration = start.elapsed();
    assert!(
        duration.as_secs() < 20,
        "Commitment generation too slow: {:?}",
        duration
    );
}

#[test]
fn test_verify_commitment_success() {
    // Should verify correct commitment
    let secret = [0x42u8; 32];
    let nullifier = [0x43u8; 32];
    let commitment = starkcash::cryptography::generate_commitment(&secret, &nullifier);

    assert!(
        starkcash::cryptography::verify_commitment(&commitment, &secret, &nullifier),
        "Should verify correct commitment"
    );
}

#[test]
fn test_verify_commitment_fail_wrong_secret() {
    // Should fail with wrong secret
    let secret1 = [0x01u8; 32];
    let secret2 = [0x02u8; 32];
    let nullifier = [0x03u8; 32];
    let commitment = starkcash::cryptography::generate_commitment(&secret1, &nullifier);

    assert!(
        !starkcash::cryptography::verify_commitment(&commitment, &secret2, &nullifier),
        "Should fail with wrong secret"
    );
}

#[test]
fn test_batch_commitments() {
    // Batch generation should work
    let secrets: Vec<[u8; 32]> = (0..10).map(|i| [i as u8; 32]).collect();
    let nullifiers: Vec<[u8; 32]> = (0..10).map(|i| [i as u8; 32]).collect();
    let inputs: Vec<(&[u8], &[u8])> = secrets.iter().zip(nullifiers.iter())
        .map(|(s, n)| (s.as_slice(), n.as_slice())).collect();

    let commitments = starkcash::cryptography::batch_generate_commitments(&inputs);

    assert_eq!(commitments.len(), 10);
}
