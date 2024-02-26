//
//  UZIAdminApp.swift
//  UZIAdmin
//
//  Created by SEAN BLAKE on 2/3/24.
//

import SwiftUI
import Firebase

@main
struct UZIAdminApp: App {
    @StateObject private var authManager = AuthManager.shared
    
    init() {
        // Configure Firebase
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
                .onAppear {
                    authManager.checkUserAuthentication()
                }
        }
    }
}
