//
//  ToDoSwiftDataApp.swift
//  ToDoSwiftData
//
//  Created by Nitin Kumar on 16/09/25.
//

import SwiftUI
import SwiftData

@main
struct ToDoSwiftDataApp: App {

    var body: some Scene {
        WindowGroup {
            ToDoListView()
                .modelContainer(for: ToDoItem.self, inMemory: true)
        }
    }
}
