//
//  ItemAppTestingApp.swift
//  ItemAppTesting
//
//  Created by Nitin Kumar on 01/12/25.
//

import SwiftUI

@main
struct ItemAppTestingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ItemViewModel())
        }
    }
}
