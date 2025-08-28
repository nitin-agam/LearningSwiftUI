//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by Nitin Kumar on 28/08/25.
//

import Foundation

// Model
struct EmojiArt {
    
    var background: URL?
    var emojis: [Emoji] = []
    
    struct Emoji {
        
        var string: String
        var size: Int
        var position: Position
        
        struct Position {
            var x: Int
            var y: Int
        }
    }
}
