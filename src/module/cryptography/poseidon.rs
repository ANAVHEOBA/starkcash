//! Poseidon hash function implementation
//! Compatible with Circom and Starknet native Poseidon (on BN254)

use ark_bn254::Fr;
use ark_ff::{BigInteger, PrimeField};
use light_poseidon::{Poseidon, PoseidonHasher};

/// Poseidon hash for two inputs (t=3)
pub fn poseidon_hash(left: &[u8; 32], right: &[u8; 32]) -> [u8; 32] {
    let mut hasher = Poseidon::<Fr>::new_circom(2).unwrap();
    let left_fr = Fr::from_be_bytes_mod_order(left);
    let right_fr = Fr::from_be_bytes_mod_order(right);
    
    let hash_fr = hasher.hash(&[left_fr, right_fr]).unwrap();
    
    let mut result = [0u8; 32];
    let hash_bytes = hash_fr.into_bigint().to_bytes_be();
    result.copy_from_slice(&hash_bytes);
    result
}

/// Poseidon hash for a single input (t=2)
pub fn poseidon_hash_single(input: &[u8; 32]) -> [u8; 32] {
    let mut hasher = Poseidon::<Fr>::new_circom(1).unwrap();
    let input_fr = Fr::from_be_bytes_mod_order(input);
    
    let hash_fr = hasher.hash(&[input_fr]).unwrap();
    
    let mut result = [0u8; 32];
    let hash_bytes = hash_fr.into_bigint().to_bytes_be();
    result.copy_from_slice(&hash_bytes);
    result
}
