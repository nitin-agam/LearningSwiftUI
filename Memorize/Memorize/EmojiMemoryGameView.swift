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
            
            Button("Shuffle") {
                withAnimation(.spring(response: 1, dampingFraction: 0.5)) {
                    viewModel.shuffle()
                }
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
                    withAnimation(.easeInOut(duration: 3)) {
                        viewModel.choose(card)
                    }
                }
        }
        .foregroundStyle(.orange)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGameViewModel())
}
