//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by Nitin Kumar on 28/08/25.
//

import SwiftUI

// Model
struct EmojiArt {
    
    var background: URL?
    private(set) var emojis: [Emoji] = []
    private var idCounter: Int = 0
    
    mutating func addEmoji(_ string: String, size: Int, position: Emoji.Position) {
        idCounter += 1
        emojis.append(.init(string: string, size: size, position: position, id: idCounter))
    }
    
    struct Emoji: Identifiable {
        
        var string: String
        var size: Int
        var position: Position
        var id: Int
        
        struct Position {
            var x: Int
            var y: Int
            
            static let zero = Self(x: 0, y: 0)
        }
    }
}

extension EmojiArt.Emoji {
    
    var font: Font {
        .system(size: CGFloat(size))
    }
}

extension EmojiArt.Emoji.Position {
    
    func `in`(_ geometry: GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(x: center.x + CGFloat(x), y: center.y - CGFloat(y))
        
    }
}
