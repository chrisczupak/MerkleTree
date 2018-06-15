import Foundation

/// An object for constructing a 'MerkleTree' that can be used for quick data verification
public class MerkleTree {
    
    /// The root node, whose hash can be used to verify the entire dataset that has been constructed below it in the tree
    public var root: MerkleNode?
    
    
    /// Initializer for a 'MerkleTree'
    ///
    /// - Parameter data: An array of objects to convert in to a 'MerkleTree'
    public init(data: [String]) {
        self.root = createTree(from: data)
    }
    
    /// A private function that does the work of hashing values and constructing the tree
    ///
    /// - Parameter data: The array to pass in from which to construct the tree
    /// - Returns: A 'MerkleNode' which should be the root node of the entire tree
    private func createTree(from data: [String]) -> MerkleNode? {
        
        // 1. If the data array is empty, return nil
        if data.isEmpty {
            
            // 1.1 Return nil if the data set is empty
            return nil
        } else if data.count == 1 {
            
            // 1.2 If the data array only contains one object, turn it in to the merkle root
            return MerkleNode(value: data[0], left: nil, right: nil)
        }
        
        
        // 2. Transform your data in to merkle nodes. These will be the leaves of the tree
        var tree: [MerkleNode] = data.map { value in
            return MerkleNode(value: value, left: nil, right: nil)
        }
        
        // 3. Loop until we get to the root node
        while tree.count > 1 {
            
            // 3.1 If the tree contains an odd number of nodes duplicate the last node for a more balanced tree
            if tree.count % 2 != 0 {
                let duplicate = tree[tree.count-1]
                tree.append(duplicate)
            }
            
            // 3.2 Ensure the tree contains an even number of nodes
            guard tree.count % 2 == 0 else { return nil }
            
            // 3.3 Create a temporary tree to hold the new layer of nodes as we work our way up
            var tempTree = [MerkleNode]()
            
            // 3.4 Walk the tree at the current height as we work our way up to the root node
            for i in stride(from: 0, to: tree.count-1, by: 2) {
                
                // 3.4.1 The left node of the new parent node
                let left = tree[i]
                
                // 3.4.2 The right node of the new parent node
                let right = tree[i+1]
                
                // 3.4.3 The new value of the new parent node will be a result of left hash + right hash
                let value = left.hash + right.hash
                
                // 3.4.5 Create the node
                let node = MerkleNode(value: value, left: left, right: right)
                
                // 3.4.6 Insert it in the temporary tree
                tempTree.append(node)
            }
            
            // 3.5 After new parent nodes have been created, set the tree to the temp tree and begin again if we haven't yet reached the root node
            tree = tempTree
        }
        
        // 4. After we're reached the root node, return it
        return tree.first
    }
    
}
