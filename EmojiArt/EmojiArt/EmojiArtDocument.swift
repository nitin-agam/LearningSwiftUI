//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Nitin Kumar on 28/08/25.
//

import SwiftUI

typealias Emoji = EmojiArt.Emoji

// ViewModel
class EmojiArtDocument: ObservableObject {
    
    var emojiArt = EmojiArt()
    
    init() {
        emojiArt.addEmoji("🐶", size: 200, position: .init(x: -200, y: 150))
        emojiArt.addEmoji("🐱", size: 100, position: .init(x: 200, y: 100))
    }
    
    var emojis: [Emoji] {
        emojiArt.emojis
    }
    
    var background: URL? {
        emojiArt.background
    }
    
    func setBackground(_ url: URL) {
        emojiArt.background = url
    }
    
    func addEmoji(_ string: String, size: CGFloat, position: Emoji.Position) {
        emojiArt.addEmoji(string, size: Int(size), position: position)
    }
}
