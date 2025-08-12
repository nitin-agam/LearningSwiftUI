//
//  MemoryGame.swift
//  Memorize
//
//  Created by Nitin Kumar on 08/08/25.
//

import Foundation

// Model
struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: [Card]
    
    init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<max(2, numberOfPairs) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
    }
    
    private var indexOfFaceUpCard: Int? {
        get {
            let faceUpCardIndices: [Int] = cards.indices.filter { index in cards[index].isFaceUp }
            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
        }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let cardIndex = cards.firstIndex(where: { $0.id == card.id } ) {
            if cards[cardIndex].isFaceUp == false && cards[cardIndex].isMatched == false {
                if let possibleMatchedIndex = indexOfFaceUpCard {
                    if cards[possibleMatchedIndex].content == cards[cardIndex].content {
                        cards[possibleMatchedIndex].isMatched = true
                        cards[cardIndex].isMatched = true
                    }
                } else {
                    indexOfFaceUpCard = cardIndex
                }
                cards[cardIndex].isFaceUp = true
            }
        }
    }
    
    func index(of card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        
        return 0
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        var id: String
    }
}
