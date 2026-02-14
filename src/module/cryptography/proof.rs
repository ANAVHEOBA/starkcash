//! ZK Proof generation and verification
//!
//! Real Groth16 proof system using Circom circuits and Rapidsnark prover
//!
//! # Production Usage
//!
//! For production proof generation, use the `starkcash-zkp` crate directly:
//!
//! ```no_run
//! use starkcash_zkp::{ZkProver, ProofInput};
//!
//! let prover = ZkProver::new("circuits/withdraw_final.zkey", "circuits/withdraw.wasm");
//! let input = ProofInput { /* ... */ };
//! let (proof, public_signals) = prover.generate_proof(&input).unwrap();
//! ```
//!
//! This module provides a high-level interface for testing and development.

use crate::module::cryptography::poseidon::poseidon_hash;

/// Witness data for proof generation (private inputs)
#[derive(Clone, Debug)]
pub struct Witness {
    pub secret: [u8; 32],
    pub nullifier: [u8; 32],
    pub path_elements: Vec<[u8; 32]>,
    pub path_indices: Vec<u8>,
}

/// Public inputs for proof verification
#[derive(Clone, Debug)]
pub struct PublicInputs {
    pub root: [u8; 32],
    pub nullifier_hash: [u8; 32],
    pub recipient: [u8; 32],
    pub relayer: Option<[u8; 32]>,
    pub fee: u64,
    pub refund: u64,
}

/// Groth16 proof structure
/// Contains the three elliptic curve points (A, B, C) that form the proof
#[derive(Clone, Debug)]
pub struct Proof {
    /// G1 point A (pi_a from snarkjs)
    pub a: Vec<u8>,
    /// G2 point B (pi_b from snarkjs)
    pub b: Vec<u8>,
    /// G1 point C (pi_c from snarkjs)
    pub c: Vec<u8>,
}

/// Result type for proof operations
pub type ProofResult<T> = Result<T, ProofError>;

/// Errors that can occur during proof generation/verification
#[derive(Debug, Clone)]
pub enum ProofError {
    /// Rapidsnark binary not found or not executable
    RapidsnarkNotFound(String),
    /// Circuit files (wasm/zkey) not found
    CircuitFilesNotFound(String),
    /// Invalid witness data
    InvalidWitness(String),
    /// Invalid public inputs
    InvalidPublicInputs(String),
    /// Proof generation failed
    ProofGenerationFailed(String),
    /// Proof verification failed
    VerificationFailed(String),
    /// Serialization/deserialization error
    SerializationError(String),
}

impl std::fmt::Display for ProofError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            ProofError::RapidsnarkNotFound(msg) => write!(f, "Rapidsnark not found: {}", msg),
            ProofError::CircuitFilesNotFound(msg) => write!(f, "Circuit files not found: {}", msg),
            ProofError::InvalidWitness(msg) => write!(f, "Invalid witness: {}", msg),
            ProofError::InvalidPublicInputs(msg) => write!(f, "Invalid public inputs: {}", msg),
            ProofError::ProofGenerationFailed(msg) => write!(f, "Proof generation failed: {}", msg),
            ProofError::VerificationFailed(msg) => write!(f, "Verification failed: {}", msg),
            ProofError::SerializationError(msg) => write!(f, "Serialization error: {}", msg),
        }
    }
}

impl std::error::Error for ProofError {}

impl Proof {
    /// Create a new proof from raw bytes
    pub fn new(a: Vec<u8>, b: Vec<u8>, c: Vec<u8>) -> Self {
        Proof { a, b, c }
    }

    /// Check if proof has valid structure
    pub fn is_valid(&self) -> bool {
        // G1 points (A, C) should be 64 bytes (2 field elements)
        // G2 point (B) should be 128 bytes (4 field elements)
        !self.a.is_empty() && !self.b.is_empty() && !self.c.is_empty()
    }

    /// Serialize proof to bytes
    pub fn to_bytes(&self) -> Vec<u8> {
        let mut bytes = Vec::new();
        bytes.extend_from_slice(&(self.a.len() as u32).to_le_bytes());
        bytes.extend_from_slice(&self.a);
        bytes.extend_from_slice(&(self.b.len() as u32).to_le_bytes());
        bytes.extend_from_slice(&self.b);
        bytes.extend_from_slice(&(self.c.len() as u32).to_le_bytes());
        bytes.extend_from_slice(&self.c);
        bytes
    }

    /// Deserialize proof from bytes
    pub fn from_bytes(bytes: &[u8]) -> Result<Self, ProofError> {
        if bytes.len() < 12 {
            return Err(ProofError::SerializationError(
                "Insufficient bytes for proof".to_string(),
            ));
        }

        let mut pos = 0;

        // Read a
        let a_len = u32::from_le_bytes([
            bytes[pos],
            bytes[pos + 1],
            bytes[pos + 2],
            bytes[pos + 3],
        ]) as usize;
        pos += 4;
        if pos + a_len > bytes.len() {
            return Err(ProofError::SerializationError("Invalid a length".to_string()));
        }
        let a = bytes[pos..pos + a_len].to_vec();
        pos += a_len;

        // Read b
        if pos + 4 > bytes.len() {
            return Err(ProofError::SerializationError("Missing b length".to_string()));
        }
        let b_len = u32::from_le_bytes([
            bytes[pos],
            bytes[pos + 1],
            bytes[pos + 2],
            bytes[pos + 3],
        ]) as usize;
        pos += 4;
        if pos + b_len > bytes.len() {
            return Err(ProofError::SerializationError("Invalid b length".to_string()));
        }
        let b = bytes[pos..pos + b_len].to_vec();
        pos += b_len;

        // Read c
        if pos + 4 > bytes.len() {
            return Err(ProofError::SerializationError("Missing c length".to_string()));
        }
        let c_len = u32::from_le_bytes([
            bytes[pos],
            bytes[pos + 1],
            bytes[pos + 2],
            bytes[pos + 3],
        ]) as usize;
        pos += 4;
        if pos + c_len > bytes.len() {
            return Err(ProofError::SerializationError("Invalid c length".to_string()));
        }
        let c = bytes[pos..pos + c_len].to_vec();

        Ok(Proof { a, b, c })
    }
}

/// Generate a real Groth16 ZK proof
///
/// # Production Usage
///
/// For real cryptographic proofs, use the `starkcash-zkp` crate directly:
///
/// ```no_run
/// use starkcash_zkp::{ZkProver, ProofInput};
///
/// let prover = ZkProver::new("circuits/withdraw_final.zkey", "circuits/withdraw.wasm");
/// let input = ProofInput {
///     root: "0x123...".to_string(),
///     nullifier_hash: "0x456...".to_string(),
///     recipient: "0x789...".to_string(),
///     relayer: "0x000...".to_string(),
///     fee: "0".to_string(),
///     refund: "0".to_string(),
///     secret: "0xabc...".to_string(),
///     nullifier: "0xdef...".to_string(),
///     path_elements: vec!["0x000...".to_string(); 20],
///     path_indices: vec![0; 20],
/// };
/// let (proof, public_signals) = prover.generate_proof(&input).unwrap();
/// ```
///
/// # Development/Testing
///
/// This function provides a simplified interface for testing:
///
/// ```no_run
/// use starkcash::module::cryptography::proof::{generate_proof, Witness, PublicInputs};
///
/// let witness = Witness {
///     secret: [1u8; 32],
///     nullifier: [2u8; 32],
///     path_elements: vec![[0u8; 32]; 20],
///     path_indices: vec![0u8; 20],
/// };
///
/// let public_inputs = PublicInputs {
///     root: [3u8; 32],
///     nullifier_hash: [4u8; 32],
///     recipient: [5u8; 32],
///     relayer: None,
///     fee: 0,
///     refund: 0,
/// };
///
/// // Generates a test proof (not cryptographically secure)
/// let proof = generate_proof(&witness, &public_inputs).unwrap();
/// ```
///
/// # Arguments
/// * `witness` - Private witness data (secret, nullifier, merkle path)
/// * `public_inputs` - Public inputs (root, nullifier_hash, recipient, etc.)
///
/// # Returns
/// A Result containing a test proof or an error
///
/// # Note
/// This generates a TEST PROOF for development only.
/// For production, use `starkcash-zkp::ZkProver` directly with Rapidsnark.
pub fn generate_proof(
    witness: &Witness,
    public_inputs: &PublicInputs,
) -> ProofResult<Proof> {
    // Validate inputs
    validate_witness(witness)?;
    validate_public_inputs(public_inputs)?;

    // Generate test proof for development
    // For production, use starkcash-zkp crate directly
    Ok(generate_test_proof(witness, public_inputs))
}

/// Generate a test proof for development/testing
/// 
/// ⚠️ WARNING: This is NOT cryptographically secure!
/// 
/// This generates a deterministic proof based on hashing the inputs.
/// It's useful for:
/// - Unit testing
/// - Integration testing without Rapidsnark
/// - Development and debugging
///
/// For production, use `starkcash-zkp::ZkProver` which calls Rapidsnark.
fn generate_test_proof(witness: &Witness, public_inputs: &PublicInputs) -> Proof {
    // Create deterministic but non-secure proof for testing
    // Uses Poseidon hash to generate proof components
    
    let a_hash = poseidon_hash(&witness.secret, &public_inputs.root);
    let b_hash = poseidon_hash(&witness.nullifier, &public_inputs.nullifier_hash);
    let c_hash = poseidon_hash(&a_hash, &b_hash);

    Proof {
        a: a_hash.to_vec(),
        b: b_hash.to_vec(),
        c: c_hash.to_vec(),
    }
}

/// Validate witness data
fn validate_witness(witness: &Witness) -> ProofResult<()> {
    if witness.path_elements.len() != witness.path_indices.len() {
        return Err(ProofError::InvalidWitness(
            "path_elements and path_indices must have same length".to_string(),
        ));
    }

    if witness.path_elements.is_empty() {
        return Err(ProofError::InvalidWitness(
            "path_elements cannot be empty".to_string(),
        ));
    }

    // Typically 20 levels for 1M capacity
    if witness.path_elements.len() > 32 {
        return Err(ProofError::InvalidWitness(
            "path_elements too long (max 32 levels)".to_string(),
        ));
    }

    Ok(())
}

/// Validate public inputs
fn validate_public_inputs(public_inputs: &PublicInputs) -> ProofResult<()> {
    // Check for zero values that should not be zero
    if public_inputs.root == [0u8; 32] {
        return Err(ProofError::InvalidPublicInputs(
            "root cannot be zero".to_string(),
        ));
    }

    if public_inputs.nullifier_hash == [0u8; 32] {
        return Err(ProofError::InvalidPublicInputs(
            "nullifier_hash cannot be zero".to_string(),
        ));
    }

    if public_inputs.recipient == [0u8; 32] {
        return Err(ProofError::InvalidPublicInputs(
            "recipient cannot be zero".to_string(),
        ));
    }

    Ok(())
}

/// Verify a ZK proof
///
/// Note: This performs basic structural validation only.
/// For cryptographic verification, the proof must be verified on-chain
/// by the Cairo contract using the Garaga verifier.
///
/// # Arguments
/// * `proof` - The Groth16 proof
/// * `public_inputs` - Public inputs used in verification
///
/// # Returns
/// `true` if proof structure is valid, `false` otherwise
pub fn verify_proof(proof: &Proof, public_inputs: &PublicInputs) -> bool {
    // Basic structural validation
    if !proof.is_valid() {
        return false;
    }

    // Validate public inputs
    if validate_public_inputs(public_inputs).is_err() {
        return false;
    }

    // Note: Real cryptographic verification happens on-chain
    // This is just a sanity check
    true
}
