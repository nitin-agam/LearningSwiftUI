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
        Pie(endAngle: .degrees(240))
            .opacity(0.4)
            .overlay {
                Text(card.content)
                    .font(.system(size: 80))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .padding(8)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity((card.isFaceUp || card.isMatched == false) ? 1 : 0)
    }
}

#Preview {
    CardView(Card(content: "X", id: "test_id"))
        .padding()
        .foregroundStyle(.orange)
}
