//
//  ContentView.swift
//  UZIAdmin
//
//  Created by SEAN BLAKE on 2/3/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        NavigationStack {
            if authManager.isUserAuthenticated {
                VStack {
                    Home()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(.black)
                .background(Color.theme.background)
            .navigationBarBackButtonHidden(true)
                
            } else {
                SignIn()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthManager())
}
