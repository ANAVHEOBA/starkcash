// Poseidon hash wrapper using Starknet's native Poseidon
// This is a simplified version for development
// For production with ZK proofs, use BN254-compatible Poseidon from Garaga

use core::poseidon::poseidon_hash_span;

/// Hash two u256 values using Poseidon
/// Compatible with Starknet's native Poseidon
pub fn poseidon_hash_2(left: u256, right: u256) -> u256 {
    // Convert u256 to felt252 array
    let mut data: Array<felt252> = array![];
    data.append(left.low.into());
    data.append(left.high.into());
    data.append(right.low.into());
    data.append(right.high.into());
    
    // Hash using Starknet's native Poseidon
    let hash_felt = poseidon_hash_span(data.span());
    
    // Convert back to u256
    hash_felt.into()
}

/// Hash a single u256 value using Poseidon
pub fn poseidon_hash_single(input: u256) -> u256 {
    let mut data: Array<felt252> = array![];
    data.append(input.low.into());
    data.append(input.high.into());
    
    let hash_felt = poseidon_hash_span(data.span());
    hash_felt.into()
}
