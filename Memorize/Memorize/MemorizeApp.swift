//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Nitin Kumar on 07/08/25.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    @StateObject private var emojiGameViewModel = EmojiMemoryGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: emojiGameViewModel)
        }
    }
}
