//! Cryptography utilities
//!
//! Helper functions for byte manipulation and validation

use rand::Rng;

/// Generate a random 32-byte array
///
/// # Returns
/// Random 32-byte array
pub fn random_bytes32() -> [u8; 32] {
    let mut rng = rand::thread_rng();
    let mut bytes = [0u8; 32];
    rng.fill(&mut bytes);
    bytes
}

/// Pad byte slice to 32 bytes with trailing zeros
///
/// # Arguments
/// * `input` - Input bytes
///
/// # Returns
/// Padded 32-byte array (input at start, zeros at end)
///
/// # Panics
/// Panics if input is longer than 32 bytes
pub fn pad_to_32_bytes(input: &[u8]) -> Vec<u8> {
    assert!(input.len() <= 32, "Input must be 32 bytes or less");

    let mut result = vec![0u8; 32];
    result[..input.len()].copy_from_slice(input);
    result
}

/// Convert bytes to hex string (without 0x prefix)
///
/// # Arguments
/// * `bytes` - Input bytes
///
/// # Returns
/// Hex string
pub fn bytes_to_hex(bytes: &[u8]) -> String {
    bytes.iter().map(|b| format!("{:02x}", b)).collect()
}

/// Convert bytes to hex string with 0x prefix
///
/// # Arguments
/// * `bytes` - Input bytes
///
/// # Returns
/// Hex string with 0x prefix
pub fn bytes_to_hex_with_prefix(bytes: &[u8]) -> String {
    format!("0x{}", bytes_to_hex(bytes))
}

/// Convert hex string to bytes
///
/// # Arguments
/// * `hex` - Hex string (with or without 0x prefix)
///
/// # Returns
/// Result containing bytes or error
pub fn hex_to_bytes(hex: &str) -> Result<Vec<u8>, String> {
    let hex = hex.strip_prefix("0x").unwrap_or(hex);

    if hex.len() % 2 != 0 {
        return Err("Hex string must have even length".to_string());
    }

    (0..hex.len())
        .step_by(2)
        .map(|i| u8::from_str_radix(&hex[i..i + 2], 16).map_err(|e| format!("Invalid hex: {}", e)))
        .collect()
}

/// XOR two byte arrays
///
/// # Arguments
/// * `a` - First array
/// * `b` - Second array
///
/// # Returns
/// XOR result
///
/// # Panics
/// Panics if arrays have different lengths
pub fn xor_bytes(a: &[u8], b: &[u8]) -> Vec<u8> {
    assert_eq!(a.len(), b.len(), "Arrays must have same length");

    a.iter().zip(b.iter()).map(|(x, y)| x ^ y).collect()
}

/// Concatenate multiple byte arrays
///
/// # Arguments
/// * `arrays` - Slice of byte arrays
///
/// # Returns
/// Concatenated bytes
pub fn concat_bytes(arrays: &[&[u8]]) -> Vec<u8> {
    let total_len: usize = arrays.iter().map(|a| a.len()).sum();
    let mut result = Vec::with_capacity(total_len);

    for arr in arrays {
        result.extend_from_slice(arr);
    }

    result
}

/// Split byte array at given position
///
/// # Arguments
/// * `bytes` - Input bytes
/// * `at` - Position to split
///
/// # Returns
/// Tuple of (left, right) slices
pub fn split_bytes(bytes: &[u8], at: usize) -> (Vec<u8>, Vec<u8>) {
    let left = bytes[..at.min(bytes.len())].to_vec();
    let right = bytes[at.min(bytes.len())..].to_vec();
    (left, right)
}

/// Check if input is valid 32-byte array
///
/// # Arguments
/// * `bytes` - Input to check
///
/// # Returns
/// `true` if exactly 32 bytes
pub fn is_valid_bytes32(bytes: &[u8]) -> bool {
    bytes.len() == 32
}

/// Constant-time comparison of two byte arrays
///
/// Prevents timing attacks by always comparing all bytes
///
/// # Arguments
/// * `a` - First array
/// * `b` - Second array
///
/// # Returns
/// `true` if arrays are equal
pub fn constant_time_compare(a: &[u8], b: &[u8]) -> bool {
    if a.len() != b.len() {
        return false;
    }

    let mut result = 0u8;
    for (x, y) in a.iter().zip(b.iter()) {
        result |= x ^ y;
    }

    result == 0
}
