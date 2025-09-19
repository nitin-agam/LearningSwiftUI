//
//  ToDoItemView.swift
//  ToDoSwiftData
//
//  Created by Nitin Kumar on 19/09/25.
//

import SwiftUI

struct ToDoItemView: View {
    
    let item: ToDoItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                if item.isCritical {
                    Image(systemName: "exclamationmark.2")
                        .foregroundStyle(.red)
                        .font(.title)
                        .bold()
                }
                
                Text(item.title)
                    .font(.title2)
                    .bold()
                
                Text("\(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .shortened))")
                    .font(.callout)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "checkmark.circle")
                    .symbolVariant(.fill)
                    .font(.largeTitle)
                    .foregroundStyle(item.isCompleted ? .green : .gray)
            }
        }
    }
}

#Preview {
    ToDoItemView(item: .init(title: "Sample Item", isCritical: true))
}
