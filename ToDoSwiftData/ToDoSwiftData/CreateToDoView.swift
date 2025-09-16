//
//  CreateToDoView.swift
//  ToDoSwiftData
//
//  Created by Nitin Kumar on 16/09/25.
//

import SwiftUI

struct CreateToDoView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        List {
            TextField("Name", text: .constant(""))
            DatePicker("Date", selection: .constant(.now))
            Toggle("Important?", isOn: .constant(false))
            Button {
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
}
