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
    @Published var recentMessages: [RecentMessage] = []
    
    init() {
        
        DispatchQueue.main.async {
            self.isCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser == nil
        }
        
        fetchCurrentUser()
        fetchRecentMessages()
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
    
    func fetchRecentMessages() {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.firestore
            .collection("recent_messages")
            .document(uid)
            .collection("messages")
            .order(by: "createdAt")
            .addSnapshotListener { querySnapshot, error in
                
                if let error = error {
                    print("Failed to fetch recent messages: \(error)")
                    return
                }
                
                querySnapshot?.documentChanges.forEach { documentChange in
                    let documentId = documentChange.document.documentID
                    if let index = self.recentMessages.firstIndex(where: { rm in
                        rm.documentId == documentId
                    }) {
                        self.recentMessages.remove(at: index)
                    }
                    
                    let message = RecentMessage(documentId: documentId,
                                                data: documentChange.document.data())
                    self.recentMessages.insert(message, at: 0)
                }
            }
    }
    
    func handleSignOut() {
        isCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
}
