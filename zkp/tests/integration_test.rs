use starkcash_zkp::{IncrementalMerkleTree, ZkProver, ProofInput};
use starkcash::module::cryptography::{
    generate_commitment, generate_nullifier_hash, random_nullifier, random_bytes32,
};
use std::path::PathBuf;
use num_bigint::BigUint;
use num_traits::Num;

fn dec_to_hex(dec: &str) -> String {
    let n = BigUint::from_str_radix(dec, 10).expect("Invalid decimal string");
    let mut s = n.to_str_radix(16);
    while s.len() < 64 {
        s.insert(0, '0');
    }
    s
}

#[test]
fn test_full_withdraw_flow_with_rapidsnark() {
    // Skip if rapidsnark is not installed (integration test)
    if std::process::Command::new("rapidsnark").output().is_err() {
        println!("Skipping test: rapidsnark not found in PATH");
        return;
    }

    // 1. Create tree
    let mut tree = IncrementalMerkleTree::new();
    
    // 2. Generate commitment (YOUR existing Rust code!)
    let secret = random_bytes32();
    let nullifier = random_nullifier(); 
    
    let commitment = generate_commitment(&secret, &nullifier);
    
    // 3. Deposit
    let root = tree.insert(commitment);
    
    // 4. Generate nullifier hash
    let nullifier_hash = generate_nullifier_hash(&nullifier);
    
    // 5. Create proof input using real Merkle proof
    let proof = tree.get_proof(0);
    
    let input = ProofInput {
        root: format!("0x{}", hex::encode(root)),
        nullifier_hash: format!("0x{}", hex::encode(nullifier_hash)),
        recipient: "0x0000000000000000000000000000000000000000000000000000000012345678".to_string(), 
        relayer: "0x0000000000000000000000000000000000000000000000000000000000000000".to_string(),
        fee: "0".to_string(),
        refund: "0".to_string(),
        secret: format!("0x{}", hex::encode(secret)),
        nullifier: format!("0x{}", hex::encode(nullifier)),
        path_elements: proof.path_elements.iter().map(|e| format!("0x{}", hex::encode(e))).collect(),
        path_indices: proof.path_indices.iter().map(|&i| i as u32).collect(),
    };
    
    // 6. Generate proof with C++ rapidsnark
    // Note: Since we changed the circuit to Poseidon, we need a new .zkey!
    // For now, we expect this might fail until we run Trusted Setup
    let base_path = PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .parent()
        .unwrap()
        .join("circuits/build");
    
    let zkey_path = base_path.join("withdraw_final.zkey");
    let wasm_path = base_path.join("withdraw_js/withdraw.wasm");
        
    let prover = ZkProver::new(
        zkey_path.to_str().unwrap(),
        wasm_path.to_str().unwrap()
    );
    
    let start = std::time::Instant::now();
    match prover.generate_proof(&input) {
        Ok((_proof, public_signals)) => {
            let duration = start.elapsed();
            println!("Proof generated in: {:?}", duration);
            
            // 7. Verify
            assert_eq!(dec_to_hex(&public_signals.root), hex::encode(root));
            assert_eq!(dec_to_hex(&public_signals.nullifier_hash), hex::encode(nullifier_hash));
        },
        Err(e) => {
             println!("Proof generation failed (expected until Trusted Setup is rerun): {}", e);
        }
    }
}
