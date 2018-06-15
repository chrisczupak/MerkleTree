import Foundation

/// An object for storing hashed values and constructing a 'MerkleTree'
public class MerkleNode {
    
    /// This will be a 32 bit hash created from the SHA256 hashing algorithm
    public var hash: String
    
    /// Left child. This will be 'nil' if the node is a leaf, but should contain a MerkleNode otherwise
    public var leftNode: MerkleNode?
    
    /// Right child. This will be 'nil' if the node is a leaf, but should contain a MerkleNode otherwise
    public var rightNode: MerkleNode?
    
    /// Initializer for a 'MerkleNode'
    ///
    /// - Parameters:
    ///   - value: This is the value that the 'MerkleNode' will hash and store for data verification
    ///   - left: will be another 'MerkleNode' or nil
    ///   - right: will be another 'MerkleNode' or nil
    public init(value: String, left: MerkleNode?, right: MerkleNode?) {
        
        // 1. Hash the value we pass in using SHA256
        self.hash = value.sha256()
        
        // 2. Set the left child
        self.leftNode = left
        
        // 3. Set the right child
        self.rightNode = right
    }
    
}
