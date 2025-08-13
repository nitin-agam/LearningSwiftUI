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
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(style: .init(lineWidth: 2))
                Text(card.content)
                    .font(.system(size: 80))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity((card.isFaceUp || card.isMatched == false) ? 1 : 0)
    }
}

#Preview {
    CardView(Card(content: "X", id: "test_id"))
        .padding()
        .foregroundStyle(.orange)
}
