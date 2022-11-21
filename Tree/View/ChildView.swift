//
//  ChildView.swift
//  Tree
//
//  Created by Кирилл Пономаренко on 21.11.2022.
//

import SwiftUI

struct ChildView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State private var presentAlert = false
    @State private var currentText = ""
    
    @ObservedObject var viewModel: NodeViewModel
    
    init(viewModel: NodeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            
            ChildsList(nodes: $viewModel.currentChildrens)
            
            Spacer()
            
            HStack {
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
                
                Spacer()
                
                Button {
                    viewModel.delete()
                    mode.wrappedValue.dismiss()
                } label: {
                    Text("Удалить")
                }
                .foregroundColor(.red)
            }
        }
        .padding()
        .navigationTitle(viewModel.node.name)
    }
}
