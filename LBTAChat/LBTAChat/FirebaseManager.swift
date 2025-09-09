//
//  FirebaseManager.swift
//  LBTAChat
//
//  Created by Nitin Kumar on 31/08/25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

class FirebaseManager: NSObject {
    
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    static let shared = FirebaseManager()
    
    override init() {
        
        // Firebase configuration
        FirebaseApp.configure()
        
        // Supporting object initializing
        auth = Auth.auth()
        storage = Storage.storage()
        firestore = Firestore.firestore()
        
        super.init()
    }
}
