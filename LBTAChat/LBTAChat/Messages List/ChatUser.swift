//
//  ChatUser.swift
//  LBTAChat
//
//  Created by Nitin Kumar on 10/09/25.
//

import Foundation

struct ChatUser: Identifiable {
    
    var id: String {
        uid
    }
    
    let uid, email, profileImageUrl: String
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
    }
}
