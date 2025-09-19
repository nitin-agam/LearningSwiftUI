//
//  ToDoListView.swift
//  ToDoSwiftData
//
//  Created by Nitin Kumar on 16/09/25.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
    
    @Environment(\.modelContext) var context
    @State private var showCreateToDoView = false
    @Query private var items: [ToDoItem]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    ToDoItemView(item: item)
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation {
                                    context.delete(item)
                                    try? context.save()
                                }
                            } label: {
                                Image(systemName: "trash")
                                    .symbolVariant(.fill)
                                    .font(.largeTitle)
                            }

                        }
                }
            }
            .navigationTitle("ToDo List")
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
        .modelContainer(for: ToDoItem.self, inMemory: true) { result in
            switch result {
            case .success(let container):
                let context = container.mainContext
                context.insert(ToDoItem(title: "Buy milk", isCritical: true))
                context.insert(ToDoItem(title: "Finish SwiftData guide", isCritical: true))
            case .failure(let error):
                print("Failed to create in-memory ModelContainer: \(error)")
            }
        }
}
