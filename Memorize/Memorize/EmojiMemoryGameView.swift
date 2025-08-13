//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Nitin Kumar on 07/08/25.
//

import SwiftUI

// View
struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    private let cardAspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack {
            cards
                .animation(.default, value: viewModel.cards)
            
            Button("Shuffle") {
                viewModel.shuffle()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 6)
            .background(.blue)
            .foregroundStyle(.white)
            .font(.system(size: 18, weight: .semibold))
            .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: cardAspectRatio) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundStyle(.orange)
    }
}

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
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
    EmojiMemoryGameView(viewModel: EmojiMemoryGameViewModel())
}
