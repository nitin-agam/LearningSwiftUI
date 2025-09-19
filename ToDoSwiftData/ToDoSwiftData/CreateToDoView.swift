//
//  CreateToDoView.swift
//  ToDoSwiftData
//
//  Created by Nitin Kumar on 16/09/25.
//

import SwiftUI
import SwiftData

struct CreateToDoView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @State private var item = ToDoItem()
    
    var body: some View {
        
        List {
            TextField("Name", text: $item.title)
            DatePicker("Date", selection: $item.timestamp)
            Toggle("Important?", isOn: $item.isCritical)
            Button {
                withAnimation {
                    context.insert(item)
                    try? context.save()
                }
                dismiss()
            } label: {
                Text("Create")
            }
        }
        .navigationTitle("New ToDo")
    }
}

#Preview {
    CreateToDoView()
        .modelContainer(for: ToDoItem.self, inMemory: true)
}
