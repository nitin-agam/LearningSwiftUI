//
//  RecentMessage.swift
//  LBTAChat
//
//  Created by Nitin Kumar on 14/09/25.
//

import Foundation
import Firebase

struct RecentMessage: Identifiable {
    
    var id: String {
        documentId
    }
    
    let text: String
    let senderId: String
    let receiverId: String
    let documentId: String
    let createdAt: Timestamp
    let email: String
    let profileImageUrl: String
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        text = data["text"] as? String ?? ""
        senderId = data["senderId"] as? String ?? ""
        receiverId = data["receiverId"] as? String ?? ""
        createdAt = data["createdAt"] as? Timestamp ?? Timestamp(date: Date())
        email = data["email"] as? String ?? ""
        profileImageUrl = data["profileImageUrl"] as? String ?? ""
    }
}
