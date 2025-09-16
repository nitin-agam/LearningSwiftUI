//
//  ChatMessage.swift
//  LBTAChat
//
//  Created by Nitin Kumar on 12/09/25.
//

import Foundation
import Firebase

struct ChatMessage: Identifiable {
    
    var id: String {
        documentId
    }
    
    let text: String
    let senderId: String
    let receiverId: String
    let documentId: String
    let createdAt: Timestamp?
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        text = data["text"] as? String ?? ""
        senderId = data["senderId"] as? String ?? ""
        receiverId = data["receiverId"] as? String ?? ""
        createdAt = data["createdAt"] as? Timestamp
    }
}
