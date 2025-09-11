//
//  ChatLogView.swift
//  LBTAChat
//
//  Created by Nitin Kumar on 11/09/25.
//

import SwiftUI

struct ChatLogView: View {
    
    @State private var chatText = ""
    let chatUser: ChatUser?
    
    var body: some View {
        chatHistoryView
//        ZStack {
//            chatHistoryView
//            VStack {
//                Spacer()
//                inputBoxView
//                    .background(.white)
//            }
//        }
        .navigationTitle(chatUser?.email ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    private var chatHistoryView: some View {
        ScrollView {
            ForEach(0..<40) { _ in
                HStack {
                    Spacer()
                    HStack {
                        Text("Fake Message Here...")
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .background(.blue)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            
            HStack {
                Spacer()
            }
        }
        .background(Color(.init(white: 0.95, alpha: 1)))
        .safeAreaInset(edge: .bottom) {
            chatBottomBar
                .background(Color(.systemBackground).ignoresSafeArea())
        }
    }
    
    private var chatBottomBar: some View {
        HStack(spacing: 10) {
            Button {
                
            } label: {
                Image(systemName: "photo.on.rectangle.angled")
                    .font(.system(size: 24))
                    .foregroundStyle(Color(.darkGray))
            }
            
            TextField("Enter message..", text: $chatText)
                .font(.system(size: 16, weight: .medium))

            Button {
                
            } label: {
                Text("Send")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(.blue)
                    .font(.system(size: 16, weight: .semibold))
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

#Preview {
    ChatLogView(chatUser: .init(data: ["uid": "SBsFalfmrYTP0KgBb8jWWgddaCH2", "email": "testing@gmail.com", "profileImageUrl": "empty"]))
}
