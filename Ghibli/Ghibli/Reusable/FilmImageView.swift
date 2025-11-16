//
//  FilmImageView.swift
//  Ghibli
//
//  Created by Nitin Kumar on 12/11/25.
//

import SwiftUI

struct FilmImageView: View {
    
    let url: URL?
    
    init(urlPath: String) {
        self.url = URL(string: urlPath)
    }
    
    init(url: URL?) {
        self.url = url
    }
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
                case .empty:
                    Color(white: 0.8)
                        .overlay {
                            ProgressView()
                                .controlSize(.large)
                        }
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                    
                case .failure(_):
                    Text("Couldn't get an image")
                    
                @unknown default:
                    EmptyView()
            }
        }
    }
}

#Preview("Poster Image") {
    FilmImageView(url: URL.convertAssetImage(named: "posterImage"))
        .frame(height: 150)
}

#Preview("Banner Image") {
    FilmImageView(url: URL.convertAssetImage(named: "bannerImage"))
        .frame(height: 300)
}
