//
//  MessagesListViewModel.swift
//  LBTAChat
//
//  Created by Nitin Kumar on 09/09/25.
//

import Foundation

class MessagesListViewModel: ObservableObject {
    
    @Published var statusMessage = ""
    @Published var currentUser: ChatUser?
    
    init() {
        fetchCurrentUser()
    }
    
    var username: String? {
        currentUser?.email.components(separatedBy: "@").first
    }
    
    var profileImageURL: URL? {
        URL(string: currentUser?.profileImageUrl ?? "")
    }
    
    private func fetchCurrentUser() {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { [self] snapshot, error in
            
            if let error = error {
                self.statusMessage = "failed to fetch current user...: \(error)"
                return
            }
            
            guard let data = snapshot?.data() else {
                self.statusMessage = "failed to fetch user data..."
                return
            }
            
            self.statusMessage = "Data: \(data)"
            
            guard let uid = data["uid"] as? String,
            let email = data["email"] as? String,
            let profileImageUrl = data["profileImageUrl"] as? String else {
                return
            }
            
            self.currentUser = ChatUser(uid: uid, email: email, profileImageUrl: profileImageUrl)
        }
    }
}
