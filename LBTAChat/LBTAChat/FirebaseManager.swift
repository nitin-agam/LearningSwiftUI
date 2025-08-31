//
//  FirebaseManager.swift
//  LBTAChat
//
//  Created by Nitin Kumar on 31/08/25.
//

import Foundation
import Firebase
import FirebaseAuth

class FirebaseManager: NSObject {
    
    let auth: Auth
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        auth = Auth.auth()
        super.init()
    }
}
