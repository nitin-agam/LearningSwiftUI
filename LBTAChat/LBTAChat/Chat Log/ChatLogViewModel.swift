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
    @Published var messages: [ChatMessage] = []
    @Published var count = 0
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        fetchChatLog()
    }
    
    private func fetchChatLog() {
        
        guard let senderId = FirebaseManager.shared.auth.currentUser?.uid,
              let receiverId = chatUser?.uid else { return }
        
        FirebaseManager.shared.firestore
            .collection("messages")
            .document(senderId)
            .collection(receiverId)
            .order(by: "createdAt")
            .addSnapshotListener { querySnapshot, error in
                
                if let error = error {
                    print("Failed to send message data: \(error)")
                    return
                }
                
                querySnapshot?.documentChanges.forEach { documentChange in
                    if documentChange.type == .added {
                        let message = ChatMessage(documentId: documentChange.document.documentID, data: documentChange.document.data())
                        self.messages.append(message)
                    }
                }
                
                DispatchQueue.main.async {
                    self.count += 1
                }
            }
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
            self.persistRecentMessage()
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
    
    private func persistRecentMessage() {
        
        guard let senderId = FirebaseManager.shared.auth.currentUser?.uid,
              let receiverId = chatUser?.uid else { return }
        
        let senderDocument = FirebaseManager.shared.firestore
            .collection("recent_messages")
            .document(senderId)
            .collection("messages")
            .document(receiverId)
        
        let senderData: [String: Any] = ["senderId": senderId,
                                          "receiverId": receiverId,
                                          "text": chatText,
                                          "createdAt": Timestamp(),
                                          "email": chatUser?.email ?? "",
                                          "profileImageUrl": chatUser?.profileImageUrl ?? ""]
        
        senderDocument.setData(senderData) { error in
            if let error = error {
                print("Failed to send recent message data for sender: \(error)")
                return
            }
        }
        
        
        
        let receiverDocument = FirebaseManager.shared.firestore
            .collection("recent_messages")
            .document(receiverId)
            .collection("messages")
            .document(senderId)
        
        let receiverData: [String: Any] = ["senderId": senderId,
                                         "receiverId": receiverId,
                                         "text": chatText,
                                         "createdAt": Timestamp(),
                                           "email": FirebaseManager.shared.auth.currentUser?.email ?? "",
                                         "profileImageUrl": ""]
        
        receiverDocument.setData(receiverData) { error in
            if let error = error {
                print("Failed to send recent message data for receiver: \(error)")
                return
            }
        }
    }
}
