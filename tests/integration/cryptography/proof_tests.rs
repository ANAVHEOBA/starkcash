//! Integration tests for ZK proof generation and verification
//!
//! Tests Groth16 proof system integration

#[test]
fn test_proof_generation_with_valid_witness() {
    // Valid witness should generate proof
    let witness = starkcash::cryptography::Witness {
        secret: [0x01u8; 32],
        nullifier: [0x02u8; 32],
        path_elements: vec![[0x03u8; 32]; 20],
        path_indices: vec![0u8; 20],
    };

    let public_inputs = starkcash::cryptography::PublicInputs {
        root: [0x04u8; 32],
        nullifier_hash: [0x05u8; 32],
        recipient: [0x06u8; 32],
        relayer: Some([0x07u8; 32]),
        fee: 100,
        refund: 0,
    };

    let proof = starkcash::cryptography::generate_proof(&witness, &public_inputs);

    assert!(proof.is_valid(), "Should generate valid proof");
    assert!(!proof.a.is_empty(), "Proof component A should not be empty");
    assert!(!proof.b.is_empty(), "Proof component B should not be empty");
    assert!(!proof.c.is_empty(), "Proof component C should not be empty");
}

#[test]
fn test_proof_verification_success() {
    // Valid proof should verify
    let witness = create_valid_witness();
    let public_inputs = create_valid_public_inputs();
    let proof = starkcash::cryptography::generate_proof(&witness, &public_inputs);

    let is_valid = starkcash::cryptography::verify_proof(&proof, &public_inputs);

    assert!(is_valid, "Valid proof should verify");
}

#[test]
fn test_proof_verification_fails_with_wrong_public_inputs() {
    // Proof should not verify with wrong inputs
    let witness = create_valid_witness();
    let original_inputs = create_valid_public_inputs();
    let proof = starkcash::cryptography::generate_proof(&witness, &original_inputs);

    let mut wrong_inputs = original_inputs.clone();
    wrong_inputs.recipient = [0xffu8; 32];
    let is_valid = starkcash::cryptography::verify_proof(&proof, &wrong_inputs);

    assert!(
        !is_valid,
        "Proof should not verify with wrong public inputs"
    );
}

#[test]
fn test_proof_verification_fails_with_tampered_proof() {
    // Tampered proof should not verify
    let witness = create_valid_witness();
    let public_inputs = create_valid_public_inputs();
    let mut proof = starkcash::cryptography::generate_proof(&witness, &public_inputs);

    proof.a[0] = proof.a[0].wrapping_add(1);
    let is_valid = starkcash::cryptography::verify_proof(&proof, &public_inputs);

    assert!(!is_valid, "Tampered proof should not verify");
}

#[test]
fn test_proof_binding_to_witness() {
    // Different witnesses should produce different proofs
    let public_inputs = create_valid_public_inputs();
    let witness1 = create_valid_witness_with_secret([0x01u8; 32]);
    let witness2 = create_valid_witness_with_secret([0x02u8; 32]);

    let proof1 = starkcash::cryptography::generate_proof(&witness1, &public_inputs);
    let proof2 = starkcash::cryptography::generate_proof(&witness2, &public_inputs);

    assert!(
        starkcash::cryptography::verify_proof(&proof1, &public_inputs),
        "Proof 1 should verify"
    );
    assert!(
        starkcash::cryptography::verify_proof(&proof2, &public_inputs),
        "Proof 2 should verify"
    );
    assert_ne!(
        proof1.a, proof2.a,
        "Different witnesses should produce different proofs"
    );
}

#[test]
fn test_proof_serialization_roundtrip() {
    // Proof should serialize and deserialize correctly
    let witness = create_valid_witness();
    let public_inputs = create_valid_public_inputs();
    let proof = starkcash::cryptography::generate_proof(&witness, &public_inputs);

    let serialized = proof.to_bytes();
    let deserialized = starkcash::cryptography::Proof::from_bytes(&serialized);

    assert_eq!(proof.a, deserialized.a, "Component A should match");
    assert_eq!(proof.b, deserialized.b, "Component B should match");
    assert_eq!(proof.c, deserialized.c, "Component C should match");

    assert!(
        starkcash::cryptography::verify_proof(&deserialized, &public_inputs),
        "Deserialized proof should verify"
    );
}

#[test]
fn test_proof_size_is_constant() {
    // Groth16 proofs should have constant size
    let public_inputs = create_valid_public_inputs();

    let proof1 = starkcash::cryptography::generate_proof(
        &create_valid_witness_with_secret([0x01u8; 32]),
        &public_inputs,
    );
    let proof2 = starkcash::cryptography::generate_proof(
        &create_valid_witness_with_secret([0x02u8; 32]),
        &public_inputs,
    );
    let proof3 = starkcash::cryptography::generate_proof(
        &create_valid_witness_with_secret([0x03u8; 32]),
        &public_inputs,
    );

    assert_eq!(
        proof1.to_bytes().len(),
        proof2.to_bytes().len(),
        "Proofs should have constant size"
    );
    assert_eq!(
        proof2.to_bytes().len(),
        proof3.to_bytes().len(),
        "Proofs should have constant size"
    );
}

#[test]
fn test_proof_generation_performance() {
    use std::time::Instant;

    // Proof generation should be reasonably fast
    let witness = create_valid_witness();
    let public_inputs = create_valid_public_inputs();

    let start = Instant::now();
    let _proof = starkcash::cryptography::generate_proof(&witness, &public_inputs);
    let duration = start.elapsed();

    println!("Proof generation took: {:?}", duration);
    assert!(
        duration.as_secs() < 10,
        "Proof generation too slow: {:?}",
        duration
    );
}

#[test]
fn test_proof_verification_performance() {
    use std::time::Instant;

    // Verification should be fast
    let witness = create_valid_witness();
    let public_inputs = create_valid_public_inputs();
    let proof = starkcash::cryptography::generate_proof(&witness, &public_inputs);

    let start = Instant::now();
    for _ in 0..100 {
        let _ = starkcash::cryptography::verify_proof(&proof, &public_inputs);
    }
    let duration = start.elapsed();

    println!("100 proof verifications took: {:?}", duration);
    assert!(
        duration.as_millis() < 1000,
        "Verification too slow: {:?}",
        duration
    );
}

#[test]
fn test_proof_with_empty_witness() {
    // Empty witness components should fail
    let witness = starkcash::cryptography::Witness {
        secret: [0x01u8; 32],
        nullifier: [0x02u8; 32],
        path_elements: vec![],
        path_indices: vec![],
    };

    let public_inputs = create_valid_public_inputs();

    // This might panic or return invalid proof depending on implementation
    let result = std::panic::catch_unwind(|| {
        starkcash::cryptography::generate_proof(&witness, &public_inputs)
    });

    // Should either panic or produce invalid proof
    if let Ok(proof) = result {
        assert!(!proof.is_valid(), "Empty path should produce invalid proof");
    }
}

#[test]
fn test_proof_with_mismatched_path_length() {
    // Path elements and indices should match
    let witness = starkcash::cryptography::Witness {
        secret: [0x01u8; 32],
        nullifier: [0x02u8; 32],
        path_elements: vec![[0x03u8; 32]; 20],
        path_indices: vec![0u8; 19], // Mismatched length
    };

    let public_inputs = create_valid_public_inputs();

    let result = std::panic::catch_unwind(|| {
        starkcash::cryptography::generate_proof(&witness, &public_inputs)
    });

    if let Ok(proof) = result {
        assert!(
            !proof.is_valid(),
            "Mismatched path should produce invalid proof"
        );
    }
}

#[test]
fn test_proof_with_zero_values() {
    // Zero values should still work
    let witness = starkcash::cryptography::Witness {
        secret: [0x00u8; 32],
        nullifier: [0x00u8; 32],
        path_elements: vec![[0x00u8; 32]; 20],
        path_indices: vec![0u8; 20],
    };

    let mut public_inputs = create_valid_public_inputs();
    public_inputs.root = [0x00u8; 32];

    let proof = starkcash::cryptography::generate_proof(&witness, &public_inputs);
    let is_valid = starkcash::cryptography::verify_proof(&proof, &public_inputs);

    // Zero values might or might not be valid depending on circuit
    // This test documents the behavior
    println!("Zero values proof valid: {}", is_valid);
}

#[test]
fn test_proof_with_max_fee() {
    // Fee should be within bounds
    let witness = create_valid_witness();
    let mut public_inputs = create_valid_public_inputs();
    public_inputs.fee = u64::MAX;

    let proof = starkcash::cryptography::generate_proof(&witness, &public_inputs);

    // Very high fee might be rejected by circuit
    let is_valid = starkcash::cryptography::verify_proof(&proof, &public_inputs);
    println!("Max fee proof valid: {}", is_valid);
}

// Helper functions
fn create_valid_witness() -> starkcash::cryptography::Witness {
    starkcash::cryptography::Witness {
        secret: [0x01u8; 32],
        nullifier: [0x02u8; 32],
        path_elements: vec![[0x03u8; 32]; 20],
        path_indices: vec![0u8; 20],
    }
}

fn create_valid_witness_with_secret(secret: [u8; 32]) -> starkcash::cryptography::Witness {
    starkcash::cryptography::Witness {
        secret,
        nullifier: [0x02u8; 32],
        path_elements: vec![[0x03u8; 32]; 20],
        path_indices: vec![0u8; 20],
    }
}

fn create_valid_public_inputs() -> starkcash::cryptography::PublicInputs {
    starkcash::cryptography::PublicInputs {
        root: [0x04u8; 32],
        nullifier_hash: [0x05u8; 32],
        recipient: [0x06u8; 32],
        relayer: None,
        fee: 0,
        refund: 0,
    }
}
