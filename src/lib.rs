//! StarkCash - Privacy Layer for Bitcoin on Starknet
//! 
//! A modular ZK-based privacy protocol using Tornado Cash mathematics

pub mod module;

// Re-export cryptography module at top level for convenience
pub use module::cryptography;

/// Current version of the StarkCash protocol
pub const VERSION: &str = env!("CARGO_PKG_VERSION");

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_version_is_valid() {
        assert!(!VERSION.is_empty());
        assert!(VERSION.contains('.'));
    }
}