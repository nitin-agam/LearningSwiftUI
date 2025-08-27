//
//  CardView.swift
//  Memorize
//
//  Created by Nitin Kumar on 13/08/25.
//

import SwiftUI

typealias Card = MemoryGame<String>.Card

struct CardView: View {
    
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        TimelineView(.animation) { context in
            if card.isFaceUp || card.isMatched == false {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(0.4)
                    .overlay(cardContent)
                    .padding(8)
                    .cardify(isFaceUp: card.isFaceUp)
                    .opacity((card.isFaceUp || card.isMatched == false) ? 1 : 0)
                    .transition(.scale)
            } else {
                Color.clear
            }
        }
    }
    
    private var cardContent: some View {
        Text(card.content)
            .font(.system(size: 80))
            .minimumScaleFactor(0.01)
            .aspectRatio(1, contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(1), value: card.isMatched)
    }
}

extension Animation {
    
    static func spin(_ duration: TimeInterval) -> Animation {
        .linear(duration: duration).repeatForever(autoreverses: false)
    }
}

#Preview {
    CardView(Card(content: "X", id: "test_id"))
        .padding()
        .foregroundStyle(.orange)
}
