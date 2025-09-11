//
//  ChatLogView.swift
//  LBTAChat
//
//  Created by Nitin Kumar on 11/09/25.
//

import SwiftUI

struct ChatLogView: View {
    
    let chatUser: ChatUser?
    
    var body: some View {
        
        ScrollView {
            ForEach(0..<20) { _ in
                Text("Fake Message Here...")
            }
        }
        .navigationTitle(chatUser?.email ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ChatLogView(chatUser: nil)
}
