//
//  EmojiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Nitin Kumar on 08/08/25.
//

import Foundation

// ViewModel
class EmojiMemoryGameViewModel: ObservableObject {
    
    private static let emojis = ["😹", "😊", "😉", "😢", "😂", "😪", "😵", "🤔", "🥳", "🤮", "🤡", "☠️", "👻"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairs: 2) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "‼️"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: [Card] {
        return model.cards
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
