//! Nullifier generation and validation
//!
//! Prevents double-spending by ensuring each note is used only once

use crate::module::cryptography::mimc::mimc7_hash;

/// 32-byte nullifier value
pub type Nullifier = [u8; 32];

/// 32-byte nullifier hash stored on-chain
pub type NullifierHash = [u8; 32];

/// Generate nullifier from secret and seed
///
/// Formula: nullifier = MiMC7(secret, nullifier_seed)
///
/// # Arguments
/// * `secret` - 32-byte secret value
/// * `nullifier_seed` - 32-byte seed for uniqueness
///
/// # Returns  
/// 32-byte nullifier
///
/// # Panics
/// Panics if inputs are not exactly 32 bytes
pub fn generate_nullifier(secret: &[u8], nullifier_seed: &[u8]) -> Nullifier {
    assert_eq!(secret.len(), 32, "Secret must be 32 bytes");
    assert_eq!(nullifier_seed.len(), 32, "Nullifier seed must be 32 bytes");

    mimc7_hash(secret, nullifier_seed)
}

/// Generate nullifier hash from nullifier
///
/// Formula: nullifierHash = MiMC7(nullifier, 0)
///
/// # Arguments
/// * `nullifier` - 32-byte nullifier value
///
/// # Returns
/// 32-byte nullifier hash
pub fn generate_nullifier_hash(nullifier: &[u8]) -> NullifierHash {
    assert_eq!(nullifier.len(), 32, "Nullifier must be 32 bytes");

    let zero = [0u8; 32];
    mimc7_hash(nullifier, &zero)
}

/// Check if nullifier hash has been spent
///
/// # Arguments
/// * `nullifier_hash` - The hash to check
/// * `spent_nullifiers` - Set of already spent nullifiers
///
/// # Returns  
/// `true` if not spent (unique), `false` if already spent
pub fn is_nullifier_unique(nullifier_hash: &NullifierHash, spent_nullifiers: &[[u8; 32]]) -> bool {
    !spent_nullifiers.contains(nullifier_hash)
}

/// Mark nullifier as spent
///
/// # Arguments
/// * `nullifier_hash` - Hash to mark
/// * `spent_set` - Mutable set of spent nullifiers
pub fn mark_nullifier_spent(nullifier_hash: NullifierHash, spent_set: &mut Vec<NullifierHash>) {
    if !spent_set.contains(&nullifier_hash) {
        spent_set.push(nullifier_hash);
    }
}

/// Verify nullifier belongs to secret
///
/// Checks that nullifier was generated from given secret and seed
///
/// # Arguments
/// * `nullifier` - The nullifier to verify
/// * `secret` - Expected secret
/// * `seed` - Expected seed
///
/// # Returns
/// `true` if nullifier matches secret/seed
pub fn verify_nullifier_ownership(nullifier: &Nullifier, secret: &[u8], seed: &[u8]) -> bool {
    let expected = generate_nullifier(secret, seed);
    nullifier == &expected
}

/// Generate unique nullifier seed from timestamp and randomness
///
/// # Returns
/// 32-byte unique seed
pub fn generate_nullifier_seed() -> [u8; 32] {
    use rand::Rng;
    let mut rng = rand::thread_rng();
    let mut seed = [0u8; 32];
    rng.fill(&mut seed);
    seed
}
