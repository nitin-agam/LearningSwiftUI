//
//  ToDoListView.swift
//  ToDoSwiftData
//
//  Created by Nitin Kumar on 16/09/25.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
    
    @State private var showCreateToDoView = false
    @Query private var items: [ToDoItem]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    HStack {
                        VStack {
                            
                            if item.isCritical {
                                Image(systemName: "")
                            }
                            
                            Text(item.title)
                            
                            Text("\(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .shortened))")
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showCreateToDoView.toggle()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showCreateToDoView) {
                NavigationStack {
                    CreateToDoView()
                }
                .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    ToDoListView()
        .modelContainer(for: ToDoItem.self)
}
