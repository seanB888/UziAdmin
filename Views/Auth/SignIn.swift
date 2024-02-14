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
                
                // MARK: - Submit button
                Button {
                    
                } label: {
                    Text("Sign In")
                        .font(.title)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.black)
                        .padding(.horizontal)
                }
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
}

#Preview {
    SignIn()
}
