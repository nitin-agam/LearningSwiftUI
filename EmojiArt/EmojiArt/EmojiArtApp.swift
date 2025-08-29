//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Nitin Kumar on 28/08/25.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    
    @StateObject private var defaultDocument = EmojiArtDocument()
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: defaultDocument)
        }
    }
}
