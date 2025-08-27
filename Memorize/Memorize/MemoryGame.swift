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
    private(set) var score: Int = 0
    
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
                        score += 2 + cards[cardIndex].bonus + cards[possibleMatchedIndex].bonus
                    } else {
                        
                        if cards[cardIndex].hasBeenSeen {
                            score -= 1
                        }
                        
                        if cards[possibleMatchedIndex].hasBeenSeen {
                            score -= 1
                        }
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
        
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
                
                if oldValue && isFaceUp == false {
                    hasBeenSeen = true
                }
            }
        }
        
        var isMatched = false {
            didSet {
                if isMatched {
                    stopUsingBonusTime()
                }
            }
        }
        
        var hasBeenSeen = false
        let content: CardContent
        
        var id: String
        
        
        // MARK: - Bonus Time
        
        // call this when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isFaceUp && !isMatched && bonusPercentRemaining > 0, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // call this when the card goes back face down or gets matched
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
        // the bonus earned so far (one point for every second of the bonusTimeLimit that was not used)
        // this gets smaller and smaller the longer the card remains face up without being matched
        var bonus: Int {
            Int(bonusTimeLimit * bonusPercentRemaining)
        }
        
        // percentage of the bonus time remaining
        var bonusPercentRemaining: Double {
            bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime)/bonusTimeLimit : 0
        }
        
        // how long this card has ever been face up and unmatched during its lifetime
        // basically, pastFaceUpTime + time since lastFaceUpDate
        var faceUpTime: TimeInterval {
            if let lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // can be zero which would mean "no bonus available" for matching this card quickly
        var bonusTimeLimit: TimeInterval = 6
        
        // the last time this card was turned face up
        var lastFaceUpDate: Date?
        
        // the accumulated time this card was face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
    }
}
