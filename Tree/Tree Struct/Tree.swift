//
//  Tree.swift
//  Tree
//
//  Created by Кирилл Пономаренко on 21.11.2022.
//

import Foundation

class Tree {
    let rootNode: Node
    
    init(rootNode: Node) {
        self.rootNode = rootNode
    }
    
    @discardableResult
    func add(name: String, to parentNode: Node) -> Node {
        let newNode = parentNode.addChild(name: name)
        return newNode
    }
    
    func delete(_ node: Node) {
        guard let parent = node.parentNode else {
            return
        }
        
        parent.delete(node)
    }
}
