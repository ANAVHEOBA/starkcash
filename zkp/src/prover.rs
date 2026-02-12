//! ZK Proof Generation using C++ rapidsnark
use std::process::Command;
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ProofInput {
    pub root: String,
    pub nullifier_hash: String,
    pub recipient: String,
    pub relayer: String,
    pub fee: String,
    pub refund: String,
    pub secret: String,
    pub nullifier: String,
    pub path_elements: Vec<String>,
    pub path_indices: Vec<u32>,
}

#[derive(Debug, Deserialize)]
pub struct Proof {
    pub pi_a: Vec<String>,
    pub pi_b: Vec<Vec<String>>,
    pub pi_c: Vec<String>,
}

#[derive(Debug, Deserialize)]
pub struct PublicSignals {
    pub root: String,
    pub nullifier_hash: String,
    pub recipient: String,
    pub relayer: String,
    pub fee: String,
    pub refund: String,
}

pub struct ZkProver {
    zkey_path: String,
    wasm_path: String,
}

impl ZkProver {
    pub fn new(zkey_path: &str, wasm_path: &str) -> Self {
        Self {
            zkey_path: zkey_path.to_string(),
            wasm_path: wasm_path.to_string(),
        }
    }
    
    /// Generate ZK proof using C++ rapidsnark
    /// ~20x faster than JavaScript snarkjs
    pub fn generate_proof(&self, input: &ProofInput) -> Result<(Proof, PublicSignals), String> {
        // Create temp files
        let temp_dir = std::env::temp_dir();
        let timestamp = std::time::SystemTime::now()
            .duration_since(std::time::UNIX_EPOCH)
            .unwrap()
            .as_nanos();
        let input_path = temp_dir.join(format!("proof_input_{}.json", timestamp));
        let witness_path = temp_dir.join(format!("witness_{}.wtns", timestamp));
        let proof_path = temp_dir.join(format!("proof_{}.json", timestamp));
        let public_path = temp_dir.join(format!("public_{}.json", timestamp));
        
        // Write input
        let input_json = serde_json::to_string_pretty(input)
            .map_err(|e| format!("Serialize error: {}", e))?;
        
        std::fs::write(&input_path, input_json)
            .map_err(|e| format!("Write error: {}", e))?;
        
        // 1. Generate witness using node and the wasm
        // wasm_path should point to the .wasm file. 
        // We assume generate_witness.js is in the same directory.
        let wasm_dir = std::path::Path::new(&self.wasm_path).parent()
            .ok_or_else(|| "Invalid wasm_path".to_string())?;
        let generate_witness_js = wasm_dir.join("generate_witness.js");

        let witness_output = Command::new("node")
            .args(&[
                generate_witness_js.to_string_lossy().to_string(),
                self.wasm_path.clone(),
                input_path.to_string_lossy().to_string(),
                witness_path.to_string_lossy().to_string(),
            ])
            .output()
            .map_err(|e| format!("Failed to execute node for witness generation: {}", e))?;

        if !witness_output.status.success() {
            let stderr = String::from_utf8_lossy(&witness_output.stderr);
            return Err(format!("Witness generation failed: {}", stderr));
        }

        // 2. Call C++ rapidsnark (20x faster!)
        let output = Command::new("rapidsnark")
            .args(&[
                &self.zkey_path,
                &witness_path.to_string_lossy().to_string(),
                &proof_path.to_string_lossy().to_string(),
                &public_path.to_string_lossy().to_string(),
            ])
            .output()
            .map_err(|e| format!("Rapidsnark execution failed. Did you install it? Error: {}", e))?;
        
        if !output.status.success() {
            let stderr = String::from_utf8_lossy(&output.stderr);
            return Err(format!("Rapidsnark failed: {}", stderr));
        }
        
        // Read proof
        let proof_json = std::fs::read_to_string(&proof_path)
            .map_err(|e| format!("Read proof error: {}", e))?;
        let proof: Proof = serde_json::from_str(&proof_json)
            .map_err(|e| format!("Parse proof error: {}", e))?;
        
        // Read public signals
        let public_json = std::fs::read_to_string(&public_path)
            .map_err(|e| format!("Read public error: {}", e))?;
        let public_signals: PublicSignals = serde_json::from_str(&public_json)
            .map_err(|e| format!("Parse public error: {}", e))?;
            
        // Clean up temp files
        let _ = std::fs::remove_file(input_path);
        let _ = std::fs::remove_file(witness_path);
        let _ = std::fs::remove_file(proof_path);
        let _ = std::fs::remove_file(public_path);
        
        Ok((proof, public_signals))
    }
}
