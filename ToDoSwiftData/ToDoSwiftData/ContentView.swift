//
//  ContentView.swift
//  ToDoSwiftData
//
//  Created by Nitin Kumar on 16/09/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        Text("Select an item")
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ToDoItem.self, inMemory: true)
}
