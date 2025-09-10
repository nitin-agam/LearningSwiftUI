//
//  UserListView.swift
//  LBTAChat
//
//  Created by Nitin Kumar on 10/09/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel = UserListViewModel()
    
    var body: some View {
        NavigationView {
            listView
        }
    }
    
    private var listView: some View {
        ScrollView {
            ForEach(viewModel.users) { user in
                VStack(alignment: .leading) {
                    HStack {
                        WebImage(url: URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .cornerRadius(50)
                            .overlay {
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 1))
                            }
                            .shadow(radius: 5)
                        
                        Text(user.email)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(.primary)
                    }
                    .padding(.horizontal)
                    Divider()
                        .padding(.vertical, 6)
                }
            }
            .padding(.top, 10)
        }
        .navigationTitle("New Message")
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                }
            }
        }
    }
}

#Preview {
    UserListView()
}
