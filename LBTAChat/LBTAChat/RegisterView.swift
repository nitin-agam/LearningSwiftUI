//
//  ContentView.swift
//  LBTAChat
//
//  Created by Nitin Kumar on 31/08/25.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var isLoginMode = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loginStatusMessage = ""
    @State private var shouldShowImagePicker = false
    @State private var selectedProfileImage: UIImage?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Picker("", selection: $isLoginMode) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }
                    .pickerStyle(.segmented)
                    
                    if isLoginMode == false {
                        Button {
                            shouldShowImagePicker.toggle()
                        } label: {
                            VStack {
                                if let profileImage = selectedProfileImage {
                                    Image(uiImage: profileImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 120)
                                        .cornerRadius(120)
                                } else {
                                    Image(systemName: "person.fill")
                                        .frame(width: 120, height: 120)
                                        .font(.system(size: 80))
                                        .foregroundStyle(.black.opacity(0.7))
                                }
                            }
                            .overlay {
                                RoundedRectangle(cornerRadius: 120)
                                    .stroke(.black.opacity(0.2), lineWidth: 1.5)
                            }
                        }
                        .padding()
                    }
                    
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        SecureField("Password", text: $password)
                    }
                    .padding(12)
                    .background(.white)
                    
                    HStack {
                        Spacer()
                        Button {
                            handleCTAClick()
                        } label: {
                            Text(isLoginMode ? "Login" : "Create Account")
                                .foregroundStyle(.white)
                                .font(.headline)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 12)
                    .background(.blue)
                    
                    Text(loginStatusMessage)
                        .foregroundStyle(.red)

                }
                .padding()
            }
            .navigationTitle(isLoginMode ? "Login" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05)))
            .fullScreenCover(isPresented: $shouldShowImagePicker) {
                ImagePicker(image: $selectedProfileImage)
            }
        }
    }
    
    private func handleCTAClick() {
        if isLoginMode {
            loginUser()
        } else {
            createAccount()
        }
    }
    
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email,
                                               password: password) { result, error in
            guard error == nil else {
                self.loginStatusMessage = "something went wrong while login with error: \(String(describing: error))"
                print(loginStatusMessage)
                return
            }
            
            self.loginStatusMessage = "User Login: \(String(describing: result?.user.uid))"
            print(loginStatusMessage)
        }
    }
    
    private func createAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email,
                               password: password) { result, error in
            guard error == nil else {
                self.loginStatusMessage = "something went wrong while creating a user with error: \(String(describing: error))"
                print(loginStatusMessage)
                return
            }
            
            self.loginStatusMessage = "User Created: \(String(describing: result?.user.uid))"
            print(loginStatusMessage)
            
            uploadProfileImage()
        }
    }
    
    private func uploadProfileImage() {
        
        guard let imageData = selectedProfileImage?.jpegData(compressionQuality: 0.5),
        let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            return
        }
        
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        ref.putData(imageData, metadata: nil) { metadata, error in
            
            if let error = error {
                self.loginStatusMessage = "Failed to upload profile image with error: \(error)"
                print(loginStatusMessage)
                return
            }
            
            ref.downloadURL { url, error in
                if let error = error {
                    self.loginStatusMessage = "Failed to download image url with error: \(error)"
                    print(loginStatusMessage)
                    return
                }
                
                self.loginStatusMessage = "Successfully uploaded image at: \(String(describing: url?.absoluteString))"
                print(loginStatusMessage)
            }
        }
    }
}

#Preview {
    RegisterView()
}
