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
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        auth = Auth.auth()
        storage = Storage.storage()
        super.init()
    }
}
