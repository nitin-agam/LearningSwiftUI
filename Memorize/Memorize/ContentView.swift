//
//  ContentView.swift
//  Memorize
//
//  Created by Nitin Kumar on 07/08/25.
//

import SwiftUI

struct ContentView: View {
    
    private let emojis = ["😹", "😊", "😉", "😢", "😂", "😪", "😵", "🤔", "🥳"]
    @State private var cardCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountUpdater
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(.orange)
    }
    
    var cardCountUpdater: some View {
        HStack {
            addCardButton
            Spacer()
            removeCardButton
        }
    }
    
    private func cardCountButton(by offset: Int, symbol: String) -> some View {
        Button {
            cardCount += offset
        } label: {
            Image(systemName: symbol)
                .font(.title)
                .foregroundStyle(.orange)
        }
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var addCardButton: some View {
        cardCountButton(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    var removeCardButton: some View {
        cardCountButton(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
}

struct CardView: View {
    
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(style: .init(lineWidth: 2))
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
