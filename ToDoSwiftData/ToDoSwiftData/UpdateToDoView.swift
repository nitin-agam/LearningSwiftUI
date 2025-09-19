//
//  UpdateToDoView.swift
//  ToDoSwiftData
//
//  Created by Nitin Kumar on 19/09/25.
//

import SwiftUI
import SwiftData

struct UpdateToDoView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Bindable var item: ToDoItem
    
    var body: some View {
        List {
            TextField("Name", text: $item.title)
            DatePicker("Date", selection: $item.timestamp)
            Toggle("Important?", isOn: $item.isCritical)
            Button {
                withAnimation {
                    try? context.save()
                }
                dismiss()
            } label: {
                Text("Update")
            }
        }
        .navigationTitle("Update ToDo")
    }
}
