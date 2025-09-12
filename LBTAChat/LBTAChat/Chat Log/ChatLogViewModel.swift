//
//  ChatLogViewModel.swift
//  LBTAChat
//
//  Created by Nitin Kumar on 11/09/25.
//

import Foundation

class ChatLogViewModel: ObservableObject {
    
    let chatUser: ChatUser
    @Published var chatText = ""
    
    init(chatUser: ChatUser) {
        self.chatUser = chatUser
    }
    
    func handleSend() {
        
        print("Text: \(chatText)")
    }
}
