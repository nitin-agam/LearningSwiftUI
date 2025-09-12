//
//  MessageView.swift
//  LBTAChat
//
//  Created by Nitin Kumar on 12/09/25.
//

import SwiftUI

struct MessageView: View {
    
    let message: ChatMessage
    
    var body: some View {
        VStack {
            if message.senderId == FirebaseManager.shared.auth.currentUser?.uid {
                HStack {
                    Spacer()
                    
                    HStack {
                        Text(message.text)
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .background(.blue)
                    .cornerRadius(8)
                }
            } else {
                HStack {
                    HStack {
                        Text(message.text)
                            .foregroundStyle(.black)
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(8)
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

#Preview {
//    MessageView()
}
