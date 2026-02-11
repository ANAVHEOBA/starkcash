# GhostProtocol - Modular Architecture Design

> **Architecture Pattern**: Modular Design  
> **Principle**: Separation of Concerns, Composability, Testability  
> **Target**: 7 Core Modules + Supporting Infrastructure

---

## High-Level Module Overview

```
ghostprotocol/
├── 1-cryptography/          # ZK circuits, proofs, verification
├── 2-smart-contracts/       # Cairo contracts
├── 3-merkle-tree/          # Merkle tree logic (separate module)
├── 4-payment-layer/        # GhostPay features
├── 5-account-abstraction/  # AA, session keys, paymaster
├── 6-client-sdk/           # Browser/Node.js SDK
├── 7-infrastructure/       # Deployment, testing, utils
└── 8-interfaces/           # Type definitions, shared types
```

---

## Module 1: Cryptography (ZK Layer)

**Purpose**: All zero-knowledge proof logic

**Sub-modules:**
```
1-cryptography/
├── circuits/               # Circom circuits
│   ├── withdraw.circom    # Main withdrawal circuit
│   ├── hasher.circom      # MiMC hash implementations
│   └── merkle.circom      # Merkle proof verification
├── trusted-setup/         # Ceremony artifacts
│   ├── phase1/           # Powers of Tau
│   └── phase2/           # Circuit-specific
├── proving/              # Proof generation
│   ├── wasm/             # Compiled WASM provers
│   └── zkeys/            # Proving keys
├── verification/         # Verification logic
│   ├── cairo-verifier/   # Cairo verifier contract
│   └── verification-key.json
└── utils/                # Crypto helpers
    ├── field-arithmetic.ts
    └── hash-functions.ts
```

**Exports:**
- `generateProof(inputs)` → Proof
- `verifyProof(proof, publicSignals)` → boolean
- `generateCommitment(secret)` → commitment
- `generateNullifier(secret, seed)` → nullifier

**Dependencies:** None (base module)

---

## Module 2: Smart Contracts (Cairo Layer)

**Purpose**: On-chain logic, state management

**Sub-modules:**
```
2-smart-contracts/
├── contracts/
│   ├── GhostPool.cairo           # Main pool contract
│   ├── MerkleTreeWithHistory.cairo  # Tree management
│   ├── Verifier.cairo            # Groth16 verifier
│   ├── PaymentLink.cairo         # Link management
│   └── TokenWrapper.cairo        # tBTC wrapper
├── interfaces/
│   ├── IGhostPool.cairo
│   ├── IVerifier.cairo
│   └── IERC20.cairo
├── libraries/
│   ├── MiMC.cairo               # Hash library
│   ├── MerkleProof.cairo        # Proof verification
│   └── NullifierSet.cairo       # Double-spend protection
├── tests/
│   ├── test_deposit.cairo
│   ├── test_withdraw.cairo
│   └── test_payment_link.cairo
└── scripts/
    ├── deploy.cairo
    └── upgrade.cairo
```

**Exports:**
- `GhostPool` contract class
- `MerkleTreeWithHistory` contract class
- `Verifier` contract class
- Contract ABIs

**Dependencies:** 
- Module 8 (interfaces) for type definitions
- Module 1 for verification keys

---

## Module 3: Merkle Tree (Data Structure)

**Purpose**: Reusable Merkle tree implementation

**Why Separate?**: Used by both contracts AND client

**Sub-modules:**
```
3-merkle-tree/
├── src/
│   ├── tree.ts              # Core tree implementation
│   ├── incremental-tree.ts  # Incremental updates
│   ├── sparse-tree.ts      # Sparse Merkle tree (future)
│   └── proof.ts            # Proof generation/verification
├── circuits/
│   └── merkle-checker.circom  # Circuit for tree proofs
├── contracts/
│   └── MerkleTree.cairo    # Cairo implementation
├── tests/
│   ├── tree.test.ts
│   └── proof.test.ts
└── benchmarks/
    └── tree-insertion.bench.ts
```

**Exports:**
- `MerkleTree` class
- `IncrementalMerkleTree` class
- `generateProof(leaf, tree)` → MerkleProof
- `verifyProof(proof, root)` → boolean

**Dependencies:** 
- Module 1 (hash functions)
- Module 8 (types)

---

## Module 4: Payment Layer (GhostPay)

**Purpose**: Link/QR payment functionality

**Sub-modules:**
```
4-payment-layer/
├── link-generation/
│   ├── encryptor.ts         # AES-256-GCM encryption
│   ├── link-builder.ts      # URL generation
│   └── qr-generator.ts      # QR code creation
├── link-claim/
│   ├── decryptor.ts         # Note decryption
│   ├── claim-orchestrator.ts # Claim flow
│   └── expiration-check.ts  # Expiration logic
├── storage/
│   ├── ipfs-storage.ts      # IPFS for encrypted notes
│   ├── arweave-storage.ts   # Arweave (optional)
│   └── local-storage.ts     # Browser storage
├── contracts/
│   └── PaymentLink.cairo    # Link management contract
├── types/
│   ├── payment-link.ts
│   └── encrypted-note.ts
└── tests/
    ├── link-generation.test.ts
    └── link-claim.test.ts
```

**Exports:**
- `createPaymentLink(note, recipient?)` → string
- `claimPaymentLink(link, recipient)` → Transaction
- `generateQR(note)` → QRCode
- `scanQR(qrData)` → Note

**Dependencies:**
- Module 1 (cryptography for encryption)
- Module 2 (contracts)
- Module 3 (merkle proofs)
- Module 6 (client SDK for transactions)

---

## Module 5: Account Abstraction

**Purpose**: Session keys, gasless txs, social recovery

**Sub-modules:**
```
5-account-abstraction/
├── session-keys/
│   ├── key-generator.ts     # Generate session keys
│   ├── session-manager.ts   # Manage active sessions
│   └── permission-set.ts    # Define permissions
├── paymaster/
│   ├── paymaster-contract.cairo  # Paymaster contract
│   ├── gas-calculator.ts    # Gas estimation
│   └── sponsor-api.ts       # API for gas sponsorship
├── smart-accounts/
│   ├── account-factory.cairo # Account creation
│   ├── ghost-account.cairo  # Custom account contract
│   └── recovery-module.cairo # Social recovery logic
├── recovery/
│   ├── guardian-manager.ts  # Guardian management
│   ├── recovery-initiator.ts # Start recovery
│   └── recovery-executor.ts # Complete recovery
├── plugins/
│   ├── daily-limit.cairo    # Spending limits
│   ├── multi-call.cairo     # Batch transactions
│   └── signature-plugins/   # Biometric, etc.
└── tests/
    ├── session-keys.test.ts
    └── recovery.test.ts
```

**Exports:**
- `createSessionKey(wallet, permissions)` → SessionKey
- `executeWithSession(sessionKey, transaction)` → Receipt
- `createSmartAccount(owner)` → SmartAccount
- `setupRecovery(account, guardians[])` → void

**Dependencies:**
- Module 2 (contracts for account logic)
- Module 6 (client SDK)
- Module 8 (types)

---

## Module 6: Client SDK

**Purpose**: JavaScript/TypeScript SDK for developers

**Sub-modules:**
```
6-client-sdk/
├── core/
│   ├── ghost-protocol.ts    # Main SDK class
│   ├── pool-manager.ts      # Pool interactions
│   ├── note-manager.ts      # Note CRUD
│   └── event-listener.ts    # Event subscriptions
├── transactions/
│   ├── deposit.ts          # Deposit flow
│   ├── withdraw.ts         # Withdrawal flow
│   ├── payment-link.ts     # Link operations
│   └── batch-operations.ts # Batch transactions
├── providers/
│   ├── starknet-provider.ts # Starknet.js wrapper
│   ├── wallet-adapters/    # Argent, Braavos, etc.
│   └── rpc-provider.ts     # Custom RPC
├── utils/
│   ├── formatters.ts       # Amount formatting
│   ├── validators.ts       # Input validation
│   ├── converters.ts       # Unit conversion
│   └── constants.ts        # Addresses, config
├── react/                  # React hooks (optional)
│   ├── useGhostProtocol.ts
│   ├── useDeposit.ts
│   └── usePaymentLink.ts
└── tests/
    ├── integration.test.ts
    └── unit.test.ts
```

**Exports:**
- `GhostProtocol` class (main SDK)
- `GhostPay` class (payment features)
- React hooks (if React sub-module)
- Type definitions

**Dependencies:**
- Module 1 (proof generation)
- Module 3 (merkle tree)
- Module 4 (payment layer)
- Module 5 (account abstraction)
- Module 8 (types)

---

## Module 7: Infrastructure

**Purpose**: DevOps, deployment, testing, utilities

**Sub-modules:**
```
7-infrastructure/
├── deployment/
│   ├── deploy-pools.ts     # Deploy pool contracts
│   ├── deploy-verifier.ts  # Deploy verifier
│   ├── deploy-paymaster.ts # Deploy paymaster
│   └── upgrade-contracts.ts # Contract upgrades
├── testing/
│   ├── test-suite/
│   │   ├── integration/    # E2E tests
│   │   ├── unit/          # Unit tests
│   │   └── fuzzing/       # Fuzz tests
│   ├── test-helpers/
│   │   ├── mock-tokens.ts  # Deploy mock tBTC
│   │   ├── merkle-helper.ts # Tree test utils
│   │   └── proof-helper.ts  # Proof test utils
│   └── testnet/
│       ├── fund-accounts.ts # Fund test wallets
│       └── setup-localnet.ts # Local devnet
├── monitoring/
│   ├── event-indexer.ts    # Index on-chain events
│   ├── metrics-collector.ts # Analytics
│   └── alert-system.ts     # Error alerting
├── utils/
│   ├── logger.ts          # Logging utility
│   ├── config-manager.ts  # Environment config
│   └── error-handler.ts   # Error handling
└── scripts/
    ├── setup-dev.sh       # Development setup
    ├── run-tests.sh       # Test runner
    └── deploy-prod.sh     # Production deploy
```

**Exports:**
- `deploy()` → ContractAddresses
- `runTests()` → TestResults
- `fundTestAccount(address)` → void

**Dependencies:**
- All other modules (for deployment)

---

## Module 8: Interfaces & Types (Shared)

**Purpose**: Type definitions shared across all modules

**Why Separate?**: Prevents circular dependencies

**Sub-modules:**
```
8-interfaces/
├── types/
│   ├── note.ts            # GhostNote type
│   ├── proof.ts           # Proof types
│   ├── merkle.ts          # Merkle tree types
│   ├── transaction.ts     # Transaction types
│   ├── contract.ts        # Contract types
│   └── events.ts          # Event types
├── constants/
│   ├── addresses.ts       # Contract addresses
│   ├── denominations.ts   # Pool denominations
│   ├── gas.ts            # Gas constants
│   └── limits.ts         # Protocol limits
├── enums/
│   ├── pool-status.ts
│   ├── transaction-status.ts
│   └── network.ts
├── errors/
│   ├── error-codes.ts
│   └── error-messages.ts
└── config/
    ├── network-config.ts  # Sepolia, mainnet, etc.
    ├── circuit-config.ts  # Circuit parameters
    └── fee-config.ts      # Fee structures
```

**Exports:**
- All TypeScript interfaces
- All constants
- All enums
- Error classes

**Dependencies:** None (base module)

---

## Module Dependency Graph

```
                    ┌─────────────────┐
                    │   8-interfaces  │
                    │   (Base Types)  │
                    └────────┬────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
        ▼                    ▼                    ▼
┌───────────────┐   ┌───────────────┐   ┌───────────────┐
│ 1-cryptography│   │ 3-merkle-tree │   │ 7-infrastructure│
│   (ZK Layer)  │   │  (Data Str)   │   │   (DevOps)    │
└───────┬───────┘   └───────┬───────┘   └───────────────┘
        │                   │
        └─────────┬─────────┘
                  │
                  ▼
        ┌─────────────────┐
        │ 2-smart-contracts│
        │   (On-Chain)     │
        └────────┬────────┘
                 │
    ┌────────────┼────────────┐
    │            │            │
    ▼            ▼            ▼
┌────────┐ ┌──────────┐ ┌──────────┐
│4-payment│ │5-account │ │6-client  │
│ -layer  │ │  -abstraction  │ │   -sdk   │
└────────┘ └──────────┘ └──────────┘
```

---

## Alternative: Micro-Modules (12 Modules)

For even more granularity:

```
ghostprotocol/
├── 01-crypto-core/          # Basic crypto (MiMC, hashes)
├── 02-circuits/             # Circom circuits only
├── 03-prover/               # Proof generation WASM
├── 04-verifier/             # Verification logic
├── 05-merkle-core/          # Tree data structure
├── 06-pool-contract/        # GhostPool only
├── 07-payment-contract/     # PaymentLink only
├── 08-aa-contract/          # Account contracts
├── 09-payment-sdk/          # GhostPay JS SDK
├── 10-core-sdk/             # Base JS SDK
├── 11-dev-tools/            # CLI, deployment
└── 12-shared-types/         # TypeScript types
```

**Trade-offs:**
- More granular = easier to test/replace
- More granular = harder to coordinate
- 7 modules = good balance for hackathon
- 12 modules = better for production

---

## Recommended: 7 + 1 Module Structure

For the hackathon:

| Module | Lines of Code | Team Member | Week |
|--------|--------------|-------------|------|
| 1-cryptography | ~500 | Cryptography Lead | 1 |
| 2-smart-contracts | ~800 | Cairo Developer | 1-2 |
| 3-merkle-tree | ~400 | Shared | 1 |
| 4-payment-layer | ~600 | Full-Stack Dev | 2-3 |
| 5-account-abstraction | ~700 | AA Specialist | 3 |
| 6-client-sdk | ~1000 | Frontend Lead | 2-4 |
| 7-infrastructure | ~400 | DevOps | 4 |
| 8-interfaces | ~200 | Shared | Throughout |

**Total**: ~4,700 lines of core code

---

## Module Interaction Example

**User Story**: Send private BTC via link

```
User Action → Module Flow:

1. User clicks "Create Payment"
   ↓
2. client-sdk (6) generates UI event
   ↓
3. cryptography (1) generates note + commitment
   ↓
4. merkle-tree (3) prepares deposit proof
   ↓
5. smart-contracts (2) executes deposit tx
   ↓
6. payment-layer (4) encrypts note + generates link
   ↓
7. client-sdk (6) displays link to user
```

**Claim Flow**:

```
1. Recipient clicks link
   ↓
2. client-sdk (6) parses link
   ↓
3. payment-layer (4) decrypts note
   ↓
4. cryptography (1) generates ZK proof
   ↓
5. merkle-tree (3) provides proof path
   ↓
6. smart-contracts (2) verifies + transfers
   ↓
7. client-sdk (6) confirms success
```

---

## Summary

**Total Modules**: **7 Core + 1 Shared = 8 modules**

**Benefits of This Structure:**
- ✅ Each module has single responsibility
- ✅ Can test modules independently
- ✅ Easy to swap implementations (e.g., change hash function)
- ✅ Parallel development by different team members
- ✅ Clear boundaries and APIs
- ✅ Reusable across projects

**For Hackathon:**
- Start with modules 1, 3, 8 (foundations)
- Add module 2 (contracts)
- Build module 6 (SDK)
- Add module 4 (GhostPay features)
- Module 5 (AA) if time permits
- Module 7 (DevOps) throughout

Which module should we start building first?