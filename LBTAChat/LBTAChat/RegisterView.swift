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
                            
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 80))
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
        }
    }
}

#Preview {
    RegisterView()
}
