//
//  AuthManager.swift
//  UZIAdmin
//
//  Created by SEAN BLAKE on 2/15/24.
//

import Foundation

class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    @Published var isUserAuthenticated: Bool = false
    
    func checkUserAuthentication() {
        if let _ = UserDefaults.standard.string(forKey: "userToken") {
            self.isUserAuthenticated = true
        } else {
            self.isUserAuthenticated = false
        }
    }
    
    // Example method to store token (call this method upon successful sign-in)
    func storeUserToken(token: String) {
        UserDefaults.standard.set(token, forKey: "userToken")
        self.isUserAuthenticated = true
    }
    
    // Example signOut update to clear token
    func signOut(completion: @escaping (Bool) -> Void) {
        UserDefaults.standard.removeObject(forKey: "userToken")
        self.isUserAuthenticated = false
        completion(true)
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        let url = URL(string: "https://uzimmie.com/c/signin/signin.js")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(SignInResponse.self, from: data)
                    if response.success {
                        // Handle success, store token, etc.
                    } else {
                        // Handle authentication failure
                    }
                } catch {
                    print("An error occurred: \(error)")
                }
            }
        }.resume()
    }

    struct SignInResponse: Codable {
        let success: Bool
        let token: String?
        let message: String?
    }

    
//    func signIn(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
//        let url = URL(string: "https://yourbackend.com/api/signin")! // Change to your actual backend URL
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        let body: [String: Any] = [
//            "email": email,
//            "password": password
//        ]
//        
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(false, error.localizedDescription)
//                return
//            }
//            
//            guard let data = data else {
//                completion(false, "No data received")
//                return
//            }
//            
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let success = json["success"] as? Bool {
//                    DispatchQueue.main.async {
//                        completion(success, json["message"] as? String)
//                    }
//                }
//            } catch {
//                completion(false, "Failed to decode response")
//            }
//        }.resume()
//    }
}
