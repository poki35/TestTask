//
//  TreeApp.swift
//  Tree
//
//  Created by Кирилл Пономаренко on 21.11.2022.
//

import SwiftUI

@main
struct TreeApp: App {
    let tree: Tree
    
    init() {
        let rootNode = Node(name: "RootNode", parentNode: nil)
        let tree = Tree(rootNode: rootNode)
        
        let first = tree.add(name: "FirstNode", to: rootNode)
        let second = tree.add(name: "SecondNode", to: rootNode)
        let third = tree.add(name: "ThirdNode", to: rootNode)
        let fourth = tree.add(name: "FourthNode", to: rootNode)
        
        let firstF = tree.add(name: "FirstNodeF", to: first)
        let secondF = tree.add(name: "SecondNodeF", to: first)
        
        let firstS = tree.add(name: "FirstNodeS", to: second)
        let secondS = tree.add(name: "SecondNodeS", to: second)
        
        self.tree = tree
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(viewModel:
                        NodeViewModel(node: tree.rootNode)
            )
        }
    }
}
