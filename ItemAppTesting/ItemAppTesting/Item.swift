//
//  Item.swift
//  ItemAppTesting
//
//  Created by Nitin Kumar on 01/12/25.
//

import Foundation

struct Item: Identifiable {
    
    let id: UUID
    let name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
    
    static var sample: [Item] {
        [Item(name: "First"), Item(name: "Second"), Item(name: "Third"), Item(name: "Fourth")]
    }
}
