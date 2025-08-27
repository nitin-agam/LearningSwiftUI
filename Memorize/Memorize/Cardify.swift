//
//  Cardify.swift
//  Memorize
//
//  Created by Nitin Kumar on 18/08/25.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var rotation: Double
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            base.strokeBorder(style: .init(lineWidth: 2))
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0, 1, 0))
    }
}

extension View {
    public func cardify(isFaceUp: Bool = true) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
