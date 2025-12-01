//
//  ContentView.swift
//  ItemAppTesting
//
//  Created by Nitin Kumar on 01/12/25.
//

import SwiftUI

struct ContentView: View {
    
    let viewModel: ItemViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.items) { item in
                    Text(item.name)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Capsule().fill(Color.yellow))
                        .fontWeight(.semibold)
                    
                }
            }
            
            Divider()
            
            Button("Remove Last") {
                viewModel.removeLast()
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.deleteDisabled)
        }
        .padding()
    }
}

#Preview {
    ContentView(viewModel: ItemViewModel())
}
