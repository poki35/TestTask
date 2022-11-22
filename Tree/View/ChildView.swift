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
                Button("Add") {
                    presentAlert = true
                }
                .frame(width: 60, height: 20)
                .padding([.trailing, .leading], 55)
                .padding([.top, .bottom], 20)
                .foregroundColor(.white)
                .background(Color.indigo)
                .cornerRadius(25)
                .font(.system(size: 16, weight: .black, design: .rounded))
                
                .alert("Add child", isPresented: $presentAlert, actions: {
                    TextField(
                        "Name",
                        text: $currentText
                    )
                    Button(
                        "Add",
                        action: {
                            viewModel.addChild(name: currentText)
                            currentText = ""
                        }
                    )
                    Button("Cancel", role: .cancel, action: {})
                })
                
                Spacer()
                
                Button {
                    viewModel.delete()
                    mode.wrappedValue.dismiss()
                } label: {
                    Text("Delete")
                }
                .frame(width: 60, height: 20)
                .padding([.trailing, .leading], 55)
                .padding([.top, .bottom], 20)
                .foregroundColor(.red)
                .background(Color.indigo)
                .cornerRadius(25)
                .font(.system(size: 18, weight: .black, design: .rounded))
                
            }
        }
        .padding()
        .navigationTitle(viewModel.node.name)
    }
}
