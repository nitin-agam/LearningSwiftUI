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
        FirebaseManager.shared.firestore.collection("users").getDocuments { snapshot, error in
            if let error = error {
                self.statusMessage = "failed to fetch user list...: \(error)"
                return
            }
            
            snapshot?.documents.forEach { documentSnapshot in
                let user = ChatUser(data: documentSnapshot.data())
                
                if user.uid != FirebaseManager.shared.auth.currentUser?.uid {
                    self.users.append(user)
                }
            }
            
            self.statusMessage = "Fetched user count...: \(self.users.count)"
        }
    }
}
