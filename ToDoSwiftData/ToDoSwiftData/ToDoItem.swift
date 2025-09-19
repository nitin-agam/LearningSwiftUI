//
//  ToDoItem.swift
//  ToDoSwiftData
//
//  Created by Nitin Kumar on 16/09/25.
//

import SwiftUI
import SwiftData

@Model
final class ToDoItem {
    
    var title: String
    var timestamp: Date
    var isCritical: Bool
    var isCompleted: Bool
    
    init(title: String = "", timestamp: Date = .now, isCritical: Bool = false, isCompleted: Bool = false) {
        self.title = title
        self.timestamp = timestamp
        self.isCritical = isCritical
        self.isCompleted = isCompleted
    }
}
