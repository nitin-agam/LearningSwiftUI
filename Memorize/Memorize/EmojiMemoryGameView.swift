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
    @State private var lastScoreChange: (amount: Int, causedByCardId: Card.ID) = (0, "")
    private let cardAspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack {
            cards
            HStack {
                score
                Spacer()
                shuffle
            }
            .font(.system(size: 24, weight: .semibold))
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation(.spring(response: 1, dampingFraction: 0.5)) {
                viewModel.shuffle()
            }
        }
    }
    
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: cardAspectRatio) { card in
            CardView(card)
                .padding(4)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .zIndex(scoreChange(causedBy: card) != 0 ? 1 : 0)
                .onTapGesture {
                    chooseCard(card)
                }
        }
        .foregroundStyle(.orange)
    }
    
    private func chooseCard(_ card: Card) {
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, card.id)
        }
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, cardId) = lastScoreChange
        return card.id == cardId ? amount : 0
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGameViewModel())
}
