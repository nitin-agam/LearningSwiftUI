//
//  RecentMessageView.swift
//  LBTAChat
//
//  Created by Nitin Kumar on 14/09/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecentMessageView: View {
    
    let message: RecentMessage?
    
    var body: some View {
        VStack {
            NavigationLink {
                Text("destination...")
            } label: {
                HStack {
                    profileImageView(urlString: message?.profileImageUrl ?? "")
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(message?.email ?? "")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(Color(.black))
                        
                        Text(message?.text ?? "")
                            .font(.system(size: 14))
                            .foregroundStyle(Color(.darkGray))
                            .lineLimit(2)
                    }
                    Spacer()
                    Text("1d")
                }
                .padding(.horizontal)
            }
            
            Divider()
                .padding(.vertical, 6)
        }
    }
    
    @ViewBuilder
    private func profileImageView(urlString: String) -> some View {
        WebImage(url: URL(string: urlString))
            .resizable()
            .scaledToFill()
            .frame(width: 50, height: 50)
            .cornerRadius(50)
            .overlay {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 1))
            }
            .shadow(radius: 5)
    }
}

#Preview {
    RecentMessageView(message: nil)
}
