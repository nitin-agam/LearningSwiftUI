//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Nitin Kumar on 28/08/25.
//

import SwiftUI

// View
struct EmojiArtDocumentView: View {
    
    @ObservedObject var document: EmojiArtDocument
    
    private let emojiSize: CGFloat = 40
    private let emojis = "👻🍎😃🤪☹️🤯🐶🐭🦁🐵🦆🐝🐢🐄🐖🌲🌴🌵🍄🌞🌎🔥🌈🌧️🌨️☁️⛄️⛳️🚗🚙🚓🚲🛺🏍️🚘✈️🛩️🚀🚁🏰🏠❤️💤⛵️"
    
    var body: some View {
        VStack {
            documentBody
            ScrollingEmojis(emojis)
                .font(.system(size: emojiSize))
                .padding(.horizontal)
                .scrollIndicators(.hidden)
        }
    }
    
    private var documentBody: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                AsyncImage(url: document.background)
                    .position(Emoji.Position.zero.in(geometry))
                ForEach(document.emojis) { emoji in
                    Text(emoji.string)
                        .position(emoji.position.in(geometry))
                        .font(emoji.font)
                }
            }
            .dropDestination(for: Sturldata.self) { items, location in
                drop(items, at: location, in: geometry)
            }
        }
    }
    
    private func drop(_ items: [Sturldata], at location: CGPoint, in geometry: GeometryProxy) -> Bool {
        for data in items {
            switch data {
                case .url(let url):
                    document.setBackground(url)
                    return true
                    
                case .string(let emoji):
                    document.addEmoji(emoji, size: emojiSize,
                                      position: emojiPosition(at: location, in: geometry))
                    return true
                    
                default: break
            }
        }
        return false
    }
    
    private func emojiPosition(at location: CGPoint, in geometry: GeometryProxy) -> Emoji.Position {
        let center = geometry.frame(in: .local).center
        return Emoji.Position(
            x: Int(location.x - center.x),
            y: Int(-(location.y - center.y))
        )
    }
}

struct ScrollingEmojis: View {
    
    private let emojis: [String]
    
    init(_ emojis: String) {
        self.emojis = emojis.uniqued.map(String.init)
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .draggable(emoji)
                }
            }
        }
    }
}

#Preview {
    EmojiArtDocumentView(document: EmojiArtDocument())
}
