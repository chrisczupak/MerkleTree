//: Playground - noun: a place where people can play

import UIKit

// Create a dataset
let dataset = ["a", "b", "c", "d", "e"]

// Create a 'MerkleTree' and pass in your dataset
let tree = MerkleTree(data: dataset)


/*
    Manual Verification that the tree was constructed properly. This is an incredibly simple test
    to check to see if our simple MerkleTree is constructed properly and produces the correct root node
    hash.
 */

// 1. The 1st loop, creating the leaf nodes
let aHash = "a".sha256()
let bHash = "b".sha256()
let cHash = "c".sha256()
let dHash = "d".sha256()
let eHash = "e".sha256()

// 2. The 2nd loop, combining pairs of leaf nodes
let abHash = (aHash+bHash).sha256()
let cdHash = (cHash+dHash).sha256()
let eeHash = (eHash+eHash).sha256()

// 3. The 3rd loop, combining the pairs of pairs
let abcdHash = (abHash+cdHash).sha256()
let eeeeHash = (eeHash+eeHash).sha256()

// 4. The 4th loop, constructing the root node, which is a hash of all previous hashes
let rootHash = String((abcdHash+eeeeHash).sha256())

// 5. The rootHash we've manually created should match the root hash of the 'tree' we created above
let verification = rootHash == tree.root?.hash

print(rootHash)
print(tree.root!.hash)
