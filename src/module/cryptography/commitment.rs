//! Commitment scheme implementation
//!
//! Generates commitments using MiMC7 hash function: commitment = MiMC7(secret, 0)

use crate::module::cryptography::mimc::mimc7_hash;

/// 32-byte commitment value
pub type Commitment = [u8; 32];

/// Generate commitment from secret: commitment = MiMC7(secret, 0)
///
/// # Arguments
/// * `secret` - 32-byte secret value
///
/// # Returns
/// 32-byte commitment hash
///
/// # Panics
/// Panics if secret is not exactly 32 bytes
pub fn generate_commitment(secret: &[u8]) -> Commitment {
    assert_eq!(secret.len(), 32, "Secret must be 32 bytes");

    let zero = [0u8; 32];
    mimc7_hash(secret, &zero)
}

/// Hash a secret value using MiMC7
///
/// # Arguments  
/// * `secret` - 32-byte secret
///
/// # Returns
/// 32-byte hash
pub fn hash_secret(secret: &[u8]) -> [u8; 32] {
    generate_commitment(secret)
}

/// Verify that a commitment matches a secret
///
/// # Arguments
/// * `commitment` - The commitment to verify
/// * `secret` - The secret to check against
///
/// # Returns
/// `true` if commitment matches secret, `false` otherwise
pub fn verify_commitment(commitment: &Commitment, secret: &[u8]) -> bool {
    let expected = generate_commitment(secret);
    commitment == &expected
}

/// Batch generate commitments for multiple secrets
///
/// # Arguments
/// * `secrets` - Slice of 32-byte secrets
///
/// # Returns
/// Vector of commitments
pub fn batch_generate_commitments(secrets: &[&[u8]]) -> Vec<Commitment> {
    secrets
        .iter()
        .map(|secret| generate_commitment(secret))
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
    rng.fill(&mut secret);
    generate_commitment(&secret)
}
