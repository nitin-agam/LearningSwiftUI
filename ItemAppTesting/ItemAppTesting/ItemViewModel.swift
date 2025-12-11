//
//  ItemViewModel.swift
//  ItemAppTesting
//
//  Created by Nitin Kumar on 01/12/25.
//

import SwiftUI
import Observation

@Observable
class ItemViewModel {
    
    var items: [Item] = Item.sample
    var deleteDisabled = false
    
    func removeLast() {
        guard items.isEmpty == false else { return }
        items.removeLast()
        deleteDisabled = items.isEmpty
    }
}
