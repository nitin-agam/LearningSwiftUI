//
//  ChatLogViewModel.swift
//  LBTAChat
//
//  Created by Nitin Kumar on 11/09/25.
//

import Foundation
import Firebase

class ChatLogViewModel: ObservableObject {
    
    let chatUser: ChatUser?
    @Published var chatText = ""
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
    }
    
    func handleSend() {
        
        print("Text: \(chatText)")
        
        guard let senderId = FirebaseManager.shared.auth.currentUser?.uid,
        let receiverId = chatUser?.uid else { return }
        
        let messageData = ["senderId": senderId,
                           "receiverId": receiverId,
                           "text": chatText,
                           "createdAt": Timestamp()] as [String : Any]
        
        let senderDocument = FirebaseManager.shared.firestore.collection("messages")
            .document(senderId)
            .collection(receiverId)
            .document()
        
        senderDocument.setData(messageData) { error in
            if let error = error {
                print("Failed to send message data: \(error)")
                return
            }
            
            print("successfully sent message data..")
        }
        
        
        let receiverDocument = FirebaseManager.shared.firestore.collection("messages")
            .document(receiverId)
            .collection(senderId)
            .document()
        
        receiverDocument.setData(messageData) { error in
            if let error = error {
                print("Failed to send message data:: \(error)")
                return
            }
            
            print("successfully sent message data...")
        }
    }
}
