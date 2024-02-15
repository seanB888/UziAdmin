//
//  SignIn.swift
//  UZIAdmin
//
//  Created by SEAN BLAKE on 2/3/24.
//

import SwiftUI

struct SignIn: View {
    @State private var username = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var errorMessage: String?
    @State private var showingAlert = false // To control alert visibility
    @State private var alertMessage = "" // To store the error message message error messages
    @State private var isAuthenticated = false
    
    var body: some View {
        VStack {
            // MARK: - Logo
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 300)
            
            Text("Sign In")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            // MARK: -Text Fields
            VStack {
                // Username...
                HStack {
                    Image(systemName: "person.fill")
                    TextField("Username/ Password", text: $username)
                        .keyboardType(.emailAddress)
                }
                .frame(height: 55)
                .padding(.horizontal)
                .overlay(Rectangle().stroke(.black, lineWidth: 1))
                .background(.white)
                .padding(.horizontal)
                
                // Password...
                HStack {
                    Image(systemName: "lock.fill")
                    if showPassword {
                        TextField("Password", text: $password)
                            .keyboardType(.emailAddress)
                    } else {
                        SecureField("Password", text: $password)
                            .keyboardType(.emailAddress)
                    }
                    Button {
                        // button action here...
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eyes" : "eyebrow")
                            .foregroundStyle(.black)
                    }
                }
                .frame(height: 55)
                .padding(.horizontal)
                .overlay(Rectangle().stroke(.black, lineWidth: 1))
                .background(.white)
                .padding(.horizontal)
                
                // MARK: - Sign in button
                Button {
                    signInUser()
                } label: {
                    Text("Sign In")
                        .font(.title)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.black)
                        .padding(.horizontal)
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Sign In Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            
            Spacer()
            
            Text("Uzimmie Admin")
                .font(.footnote)
                .foregroundStyle(.black).opacity(0.5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundStyle(.black)
        .background(Color.theme.accent)
        
    }
    
    func signInUser() {
        AuthManager.shared.signIn(email: username, password: password) { success, message in
            if success {
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                }
            } else {
                self.alertMessage = message ?? "An unknown error occurred"
                self.showingAlert = true
            }
        }
    }
}

#Preview {
    SignIn()
}
