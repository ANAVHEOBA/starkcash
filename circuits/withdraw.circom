pragma circom 2.0.0;

include "../node_modules/circomlib/circuits/poseidon.circom";
include "merkleTree.circom";

template Withdraw(levels) {
    signal input root;
    signal input nullifierHash;
    signal input recipient;
    signal input relayer;
    signal input fee;
    signal input refund;
    signal input secret;
    signal input nullifier;
    signal input pathElements[levels];
    signal input pathIndices[levels];

    component nullifierHasher = Poseidon(1);
    nullifierHasher.inputs[0] <== nullifier;
    nullifierHasher.out === nullifierHash;

    component commitmentHasher = Poseidon(2);
    commitmentHasher.inputs[0] <== secret;
    commitmentHasher.inputs[1] <== nullifier;

    signal commitment;
    commitment <== commitmentHasher.out;

    component tree = MerkleTreeChecker(levels);
    tree.leaf <== commitment;
    tree.root <== root;
    for (var i = 0; i < levels; i++) {
        tree.pathElements[i] <== pathElements[i];
        tree.pathIndices[i] <== pathIndices[i];
    }

    signal recipientSquare;
    recipientSquare <== recipient * recipient;
}

component main {public [root, nullifierHash, recipient, relayer, fee, refund]} = Withdraw(20);
