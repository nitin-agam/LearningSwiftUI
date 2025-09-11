//
//  UserListViewModel.swift
//  LBTAChat
//
//  Created by Nitin Kumar on 10/09/25.
//

import Foundation

class UserListViewModel: ObservableObject {
    
    @Published var statusMessage = ""
    @Published var users: [ChatUser] = []
    
    init() {
        fetchUserList()
    }
    
    func fetchUserList() {
        
        guard let currentUserID = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.firestore
            .collection("users")
            .whereField("uid", isNotEqualTo: currentUserID)
            .getDocuments { snapshot, error in
            if let error = error {
                self.statusMessage = "failed to fetch user list...: \(error)"
                return
            }
            
            snapshot?.documents.forEach { documentSnapshot in
                self.users.append(ChatUser(data: documentSnapshot.data()))
            }
            
            self.statusMessage = "Fetched user count...: \(self.users.count)"
        }
    }
}
