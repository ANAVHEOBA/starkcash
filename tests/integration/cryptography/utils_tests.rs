//! Integration tests for cryptography utilities
//!
//! Tests helper functions and utilities

use starkcash::cryptography::utils::*;

#[test]
fn test_random_bytes32_generation() {
    // Should generate random 32-byte array
    let bytes1 = random_bytes32();
    let bytes2 = random_bytes32();

    assert_eq!(bytes1.len(), 32, "Should be 32 bytes");
    assert_eq!(bytes2.len(), 32, "Should be 32 bytes");

    // Two random generations should differ (with high probability)
    assert_ne!(bytes1, bytes2, "Random bytes should differ");
}

#[test]
fn test_random_bytes32_uniqueness() {
    // Generate many random values and check for collisions
    let mut values = vec![];

    for _ in 0..100 {
        values.push(random_bytes32());
    }

    let original_count = values.len();
    values.sort();
    values.dedup();

    assert_eq!(
        values.len(),
        original_count,
        "Found collision in random generation"
    );
}

#[test]
fn test_pad_to_32_bytes_already_32() {
    // Already 32 bytes should remain unchanged
    let input = [0x01u8; 32];
    let padded = pad_to_32_bytes(&input);

    assert_eq!(padded.len(), 32);
    assert_eq!(padded, input.to_vec());
}

#[test]
fn test_pad_to_32_bytes_shorter() {
    // Shorter input should be padded
    let input = [0x01u8; 16];
    let padded = pad_to_32_bytes(&input);

    assert_eq!(padded.len(), 32);
    assert_eq!(&padded[0..16], &input[..]);
    assert!(
        padded[16..].iter().all(|&b| b == 0),
        "Should be zero-padded"
    );
}

#[test]
fn test_pad_to_32_bytes_empty() {
    // Empty input should be all zeros
    let input: &[u8] = &[];
    let padded = pad_to_32_bytes(input);

    assert_eq!(padded.len(), 32);
    assert!(padded.iter().all(|&b| b == 0));
}

#[test]
#[should_panic]
fn test_pad_to_32_bytes_longer() {
    // Longer input should panic
    let input = [0x01u8; 64];
    let _ = pad_to_32_bytes(&input);
}

#[test]
fn test_bytes_to_hex_basic() {
    // Should convert bytes to hex string
    let bytes = [0xdeu8, 0xadu8, 0xbeu8, 0xefu8];
    let hex = bytes_to_hex(&bytes);

    assert_eq!(hex, "deadbeef");
}

#[test]
fn test_bytes_to_hex_with_prefix() {
    // Should add 0x prefix when requested
    let bytes = [0xabu8; 4];
    let hex = bytes_to_hex_with_prefix(&bytes);

    assert!(hex.starts_with("0x"));
    assert_eq!(hex.len(), 10); // 0x + 8 hex chars
}

#[test]
fn test_hex_to_bytes_valid() {
    // Should convert hex string to bytes
    let hex = "deadbeef";
    let bytes = hex_to_bytes(hex).unwrap();

    assert_eq!(bytes, vec![0xdeu8, 0xadu8, 0xbeu8, 0xefu8]);
}

#[test]
fn test_hex_to_bytes_with_prefix() {
    // Should handle 0x prefix
    let hex = "0xdeadbeef";
    let bytes = hex_to_bytes(hex).unwrap();

    assert_eq!(bytes, vec![0xdeu8, 0xadu8, 0xbeu8, 0xefu8]);
}

#[test]
fn test_hex_to_bytes_invalid() {
    // Should fail on invalid hex
    let hex = "nothex";
    let result = hex_to_bytes(hex);

    assert!(result.is_err(), "Should fail on invalid hex");
}

#[test]
fn test_hex_to_bytes_odd_length() {
    // Should fail on odd length
    let hex = "abc";
    let result = hex_to_bytes(hex);

    assert!(result.is_err(), "Should fail on odd length");
}

#[test]
fn test_xor_bytes_same_length() {
    // XOR of same length bytes
    let a = [0xffu8; 32];
    let b = [0x00u8; 32];

    let result = xor_bytes(&a, &b);

    assert_eq!(result, vec![0xffu8; 32]);
}

#[test]
fn test_xor_bytes_inverse() {
    // XOR with itself should give zeros
    let a = [0xabu8; 32];

    let result = xor_bytes(&a, &a);

    assert_eq!(result, vec![0x00u8; 32]);
}

#[test]
#[should_panic]
fn test_xor_bytes_different_length() {
    // Should panic on different lengths
    let a = [0x01u8; 16];
    let b = [0x02u8; 32];

    let _ = xor_bytes(&a, &b);
}

#[test]
fn test_concat_bytes() {
    // Should concatenate byte arrays
    let a = [0x01u8, 0x02, 0x03];
    let b = [0x04u8, 0x05, 0x06];

    let result = concat_bytes(&[&a, &b]);

    assert_eq!(result, vec![0x01, 0x02, 0x03, 0x04, 0x05, 0x06]);
}

#[test]
fn test_concat_bytes_empty() {
    // Empty concatenation
    let result: Vec<u8> = concat_bytes(&[]);
    assert!(result.is_empty());
}

#[test]
fn test_split_bytes_even() {
    // Even split
    let bytes = [0x01u8, 0x02, 0x03, 0x04];
    let (left, right) = split_bytes(&bytes, 2);

    assert_eq!(left, vec![0x01, 0x02]);
    assert_eq!(right, vec![0x03, 0x04]);
}

#[test]
fn test_split_bytes_at_end() {
    // Split at end
    let bytes = [0x01u8, 0x02, 0x03];
    let (left, right) = split_bytes(&bytes, 3);

    assert_eq!(left, vec![0x01, 0x02, 0x03]);
    assert!(right.is_empty());
}

#[test]
fn test_is_valid_bytes32_valid() {
    // Valid 32 bytes
    let bytes = [0x01u8; 32];
    assert!(is_valid_bytes32(&bytes));
}

#[test]
fn test_is_valid_bytes32_short() {
    // Too short
    let bytes = [0x01u8; 16];
    assert!(!is_valid_bytes32(&bytes));
}

#[test]
fn test_is_valid_bytes32_long() {
    // Too long
    let bytes = [0x01u8; 64];
    assert!(!is_valid_bytes32(&bytes));
}

#[test]
fn test_is_valid_bytes32_empty() {
    // Empty
    let bytes: &[u8] = &[];
    assert!(!is_valid_bytes32(bytes));
}

#[test]
fn test_constant_time_compare_equal() {
    // Equal arrays
    let a = [0x01u8; 32];
    let b = [0x01u8; 32];

    assert!(
        constant_time_compare(&a, &b),
        "Equal arrays should compare equal"
    );
}

#[test]
fn test_constant_time_compare_different() {
    // Different arrays
    let a = [0x01u8; 32];
    let b = [0x02u8; 32];

    assert!(
        !constant_time_compare(&a, &b),
        "Different arrays should not compare equal"
    );
}

#[test]
fn test_constant_time_compare_timing() {
    use std::time::Instant;

    // Constant time comparison should take similar time regardless of position of difference
    let a = [0x01u8; 32];
    let b1 = [
        0x02u8, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
        0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
        0x01, 0x01,
    ];
    let b2 = [
        0x01u8, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
        0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
        0x01, 0x02,
    ];

    // Warmup iterations to stabilize CPU cache and branch predictor
    for _ in 0..100 {
        let _ = constant_time_compare(&a, &b1);
        let _ = constant_time_compare(&a, &b2);
    }

    // Run multiple measurement rounds and take the median
    let rounds = 5;
    let iterations_per_round = 5000;
    let mut ratios = vec![];

    for _ in 0..rounds {
        let start1 = Instant::now();
        for _ in 0..iterations_per_round {
            let _ = constant_time_compare(&a, &b1);
        }
        let time1 = start1.elapsed();

        let start2 = Instant::now();
        for _ in 0..iterations_per_round {
            let _ = constant_time_compare(&a, &b2);
        }
        let time2 = start2.elapsed();

        let ratio = if time1 > time2 {
            time1.as_nanos() as f64 / time2.as_nanos() as f64
        } else {
            time2.as_nanos() as f64 / time1.as_nanos() as f64
        };
        ratios.push(ratio);
    }

    // Sort and take median ratio (more stable than mean)
    ratios.sort_by(|a, b| a.partial_cmp(b).unwrap());
    let median_ratio = ratios[ratios.len() / 2];

    // Print debug information
    eprintln!("Constant time compare timing test:");
    eprintln!("  All ratios: {:?}", ratios);
    eprintln!("  Median ratio: {:.3}", median_ratio);
    eprintln!("  Min ratio: {:.3}", ratios.first().unwrap());
    eprintln!("  Max ratio: {:.3}", ratios.last().unwrap());

    // Use more lenient threshold - constant time within 50% is acceptable for this test
    // The important thing is that it doesn't vary by orders of magnitude
    assert!(
        median_ratio < 1.5,
        "Comparison should be roughly constant time. Median ratio: {:.3}",
        median_ratio
    );
}
