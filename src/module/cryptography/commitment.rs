//! Commitment scheme implementation
//!
//! Generates commitments using Poseidon hash function: commitment = Poseidon(secret, nullifier)

use crate::module::cryptography::poseidon::poseidon_hash;

/// 32-byte commitment value
pub type Commitment = [u8; 32];

/// Generate commitment from secret and nullifier: commitment = Poseidon(secret, nullifier)
///
/// # Arguments
/// * `secret` - 32-byte secret value
/// * `nullifier` - 32-byte nullifier value
///
/// # Returns
/// 32-byte commitment hash
///
/// # Panics
/// Panics if inputs are not exactly 32 bytes
pub fn generate_commitment(secret: &[u8], nullifier: &[u8]) -> Commitment {
    assert_eq!(secret.len(), 32, "Secret must be 32 bytes");
    assert_eq!(nullifier.len(), 32, "Nullifier must be 32 bytes");

    let mut s = [0u8; 32];
    let mut n = [0u8; 32];
    s.copy_from_slice(secret);
    n.copy_from_slice(nullifier);

    poseidon_hash(&s, &n)
}



/// Verify that a commitment matches a secret and nullifier
///
/// # Arguments
/// * `commitment` - The commitment to verify
/// * `secret` - The secret to check against
/// * `nullifier` - The nullifier to check against
///
/// # Returns
/// `true` if commitment matches secret+nullifier, `false` otherwise
pub fn verify_commitment(commitment: &Commitment, secret: &[u8], nullifier: &[u8]) -> bool {
    let expected = generate_commitment(secret, nullifier);
    commitment == &expected
}

/// Batch generate commitments for multiple secrets
///
/// # Arguments
/// * `inputs` - Slice of (secret, nullifier) tuples
///
/// # Returns
/// Vector of commitments
pub fn batch_generate_commitments(inputs: &[(&[u8], &[u8])]) -> Vec<Commitment> {
    inputs
        .iter()
        .map(|(secret, nullifier)| generate_commitment(secret, nullifier))
        .collect()
}

/// Generate random commitment for testing
///
/// # Returns
/// Random 32-byte commitment
pub fn random_commitment() -> Commitment {
    use rand::Rng;
    let mut rng = rand::thread_rng();
    let mut secret = [0u8; 32];
    let mut nullifier = [0u8; 32];
    rng.fill(&mut secret);
    rng.fill(&mut nullifier);
    generate_commitment(&secret, &nullifier)
}
