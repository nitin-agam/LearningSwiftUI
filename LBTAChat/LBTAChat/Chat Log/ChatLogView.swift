//
//  ChatLogView.swift
//  LBTAChat
//
//  Created by Nitin Kumar on 11/09/25.
//

import SwiftUI

struct ChatLogView: View {
    
    @ObservedObject private var viewModel: ChatLogViewModel
    private let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        viewModel = ChatLogViewModel(chatUser: chatUser)
    }
    
    var body: some View {
        chatHistoryView
            .navigationTitle(viewModel.chatUser?.email ?? "")
            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarItems(trailing: Button(action: {
//                viewModel.count += 1
//            }, label: {
//                Text("Count: \(viewModel.count)")
//            }))
    }
    
    private var chatHistoryView: some View {
        ScrollView {
            ScrollViewReader { proxy in
                VStack {
                    ForEach(viewModel.messages) { message in
                        MessageView(message: message)
                    }
                    
                    HStack { Spacer() }
                        .id("empty")
                }
                .onReceive(viewModel.$count) { _ in
                    withAnimation(.easeOut(duration: 0.3)) {
                        proxy.scrollTo("empty", anchor: .bottom)
                    }
                }
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
            
            ZStack {
                DescriptionPlaceholder()
                TextEditor(text: $viewModel.chatText)
                    .opacity(viewModel.chatText.isEmpty ? 0.5 : 1)
            }
            .frame(height: 40)
            
            Button {
                viewModel.handleSend()
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
