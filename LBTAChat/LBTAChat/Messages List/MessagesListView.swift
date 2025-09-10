//
//  MessagesListView.swift
//  LBTAChat
//
//  Created by Nitin Kumar on 07/09/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct MessagesListView: View {
    
    @ObservedObject private var viewModel = MessagesListViewModel()
    @State private var isLogoutSheetPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Current User: \(viewModel.currentUser?.email ?? "NA")")
                customNavigationBar
                messageListView
            }
            .overlay (newMessageButton, alignment: .bottom)
            .navigationBarHidden(true)
        }
    }
    
    private var customNavigationBar: some View {
        HStack {
            
            WebImage(url: viewModel.profileImageURL)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .cornerRadius(50)
                .overlay {
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 1))
                }
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(viewModel.username ?? "")
                    .font(.system(size: 20, weight: .semibold))
                
                HStack(alignment: .center, spacing: 6) {
                    Circle()
                        .foregroundStyle(.green)
                        .frame(width: 10, height: 10)
                    Text("online")
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            
            Button {
                isLogoutSheetPresented.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(Color(.label))
            }
        }
        .padding()
        .actionSheet(isPresented: $isLogoutSheetPresented, content: {
            .init(title: Text("Settings"),
                  message: Text("What do you want to do?"),
                  buttons: [.destructive(Text("Sign Out"),
                                         action: {
                // handle sign out here...
                viewModel.handleSignOut()
            }), .cancel()])
        })
        .fullScreenCover(isPresented: $viewModel.isCurrentlyLoggedOut) {
            RegisterView(didCompleteLoginProcess: {
                self.viewModel.isCurrentlyLoggedOut = false
            })
        }
    }
    
    private var messageListView: some View {
        ScrollView {
            ForEach(0..<20, id: \.self) { num in
                VStack {
                    HStack {
                        Image(systemName: "person.fill")
                            .font(.system(size: 28))
                            .padding()
                            .overlay {
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 1))
                            }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Swiftable")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(.primary)
                            
                            Text("Last sent or received message will be display here...")
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)
                                .lineLimit(2)
                        }
                        Spacer()
                        Text("1d")
                    }
                    .padding(.horizontal)
                    Divider()
                        .padding(.vertical, 6)
                }
            }
            .padding(.bottom, 50)
        }
    }
    
    private var newMessageButton: some View {
        Button {
            
        } label: {
            HStack {
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
            }
            .foregroundStyle(.white)
            .padding(.vertical)
            .background(Color.blue)
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius: 15)
        }
    }
}

#Preview {
    MessagesListView()
}
