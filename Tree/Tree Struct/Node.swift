//
//  Node.swift
//  Tree
//
//  Created by Кирилл Пономаренко on 21.11.2022.
//

import Foundation
import Combine

class Node {
    private(set) var name: String
    private(set) weak var parentNode: Node?
    private(set) var childrenNodes = [Node]()
    
    let wasChanged = PassthroughSubject<Bool, Never>()
    
    init(name: String, parentNode: Node?) {
        self.name = name
        self.parentNode = parentNode
    }
    
    @discardableResult
    func addChild(name: String) -> Node {
        let node = Node(
            name: name,
            parentNode: self
        )
        
        childrenNodes.append(node)
        wasChanged.send(true)
        
        return node
    }
    
    func delete(_ node: Node) {
        guard let index = childrenNodes.firstIndex(where: { $0 === node }) else {
            return
        }
        
        childrenNodes.remove(at: index)
        wasChanged.send(true)
    }
}
