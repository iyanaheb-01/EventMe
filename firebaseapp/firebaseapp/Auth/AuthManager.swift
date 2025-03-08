//
//  File.swift
//  firebaseapp
//
//  Created by Cam on 3/3/25.
//

import Foundation
import FirebaseAuth

// Model to store authentication-related user data.
struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoURL: URL?
    
    // Initialize model using Firebase's User object.
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL
    }
}

// Singleton class responsible for handling Firebase authentication operations.
final class AuthManager {
    
    static let shared = AuthManager() // Shared instance for global access.
    private init() { } // Private initializer to enforce singleton pattern.
    
    // Retrieves the currently authenticated user.
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse) // Throw an error if no user is logged in.
        }
        
        return AuthDataResultModel(user: user)
    }
    
    // Asynchronously creates a new user with email and password.
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user) // Return user data model.
    }
    
    // Signs out the current user.
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
