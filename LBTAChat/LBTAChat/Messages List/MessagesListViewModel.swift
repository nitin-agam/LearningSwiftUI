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
    @Published var isCurrentlyLoggedOut = false
    
    init() {
        
        DispatchQueue.main.async {
            self.isCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser == nil
        }
        
        fetchCurrentUser()
    }
    
    var username: String? {
        currentUser?.email.components(separatedBy: "@").first
    }
    
    var profileImageURL: URL? {
        URL(string: currentUser?.profileImageUrl ?? "")
    }
    
    func fetchCurrentUser() {
        
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
            self.currentUser = ChatUser(data: data)
        }
    }
    
    func handleSignOut() {
        isCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
}
