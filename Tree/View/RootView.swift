//
//  RootView.swift
//  Tree
//
//  Created by Кирилл Пономаренко on 21.11.2022.
//

import SwiftUI
import Combine

protocol NodeViewModelProtocol {
    var node: Node { get }
}

struct NodeModel {
    let name: String
    let originalNode: Node
}

extension NodeModel: Equatable {
    static func == (lhs: NodeModel, rhs: NodeModel) -> Bool {
        lhs.name == rhs.name
    }
}

extension NodeModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}


final class NodeViewModel: ObservableObject, NodeViewModelProtocol {
    
    let node: Node
    
    @Published var currentChildrens = [NodeModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(node: Node) {
        self.node = node
        
        updateChildrens()
        node.wasChanged
            .sink { [weak self] _ in
                self?.updateChildrens()
            }
            .store(in: &cancellables)
    }
    
    private func updateChildrens() {
        currentChildrens = node.childrenNodes.map { NodeModel(name: $0.name, originalNode: $0) }
    }
    
    func addChild(name: String) {
        node.addChild(name: name)
    }
    
    func delete() {
        node.parentNode?.delete(node)
    }
}

struct RootView: View {
    @State var updater: Bool = false
    @State private var presentAlert = false
    @State private var currentText = ""
    
    @ObservedObject var viewModel: NodeViewModel
    
    init(viewModel: NodeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                ChildsList(nodes: $viewModel.currentChildrens)
                
                Spacer()
                
                Button("Добавить") {
                    presentAlert = true
                }
                .alert("Добавить ребенка", isPresented: $presentAlert, actions: {
                    TextField(
                        "Имя",
                        text: $currentText
                    )
                    Button(
                        "Добавить",
                        action: {
                            viewModel.addChild(name: currentText)
                            currentText = ""
                        }
                    )
                    Button("Отмена", role: .cancel, action: {})
                })
            }
            .padding()
            .navigationTitle(viewModel.node.name)
            .onAppear {
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            viewModel: NodeViewModel(
                node: TreeApp().tree.rootNode
            )
        )
    }
}


struct ChildsList: View {
    
    @Binding var nodes: [NodeModel]
    
    var body: some View {
        ForEach(nodes, id: \.self) { node in
            NavigationLink {
                ChildView(
                    viewModel: NodeViewModel(
                        node: node.originalNode
                    )
                )
            } label: {
                Text(node.name)
            }
            Spacer()
                .frame(height: 20)
        }
    }
}
