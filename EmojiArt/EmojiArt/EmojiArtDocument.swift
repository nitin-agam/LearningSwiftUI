//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Nitin Kumar on 28/08/25.
//

import SwiftUI

// ViewModel
class EmojiArtDocument {
    
    typealias Emoji = EmojiArt.Emoji
    
    var emojiArt = EmojiArt()
    
    var emojis: [Emoji] {
        emojiArt.emojis
    }
    
    var background: URL? {
        emojiArt.background
    }
    
    func setBackground(_ url: URL) {
        emojiArt.background = url
    }
}
