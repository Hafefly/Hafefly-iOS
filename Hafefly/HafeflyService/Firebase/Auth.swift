//
//  FirebaseAuth.swift
//  Hafefly
//
//  Created by Samy Mehdid on 30/9/2023.
//

import Foundation
import FirebaseAuth

final class FirebaseAuth {
    static let shared = FirebaseAuth()
    
    private init() { }
    
    public func getUser() throws -> HFUser {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        
        return HFUser(user: user)
    }
    
    public func signIn(email: String, password: String) async throws -> HFUser {
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        
        return HFUser(user: authResult.user)
    }
    
    @discardableResult
    public func createUser(email: String, password: String) async throws -> HFUser {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return HFUser(user: authResult.user)
    }
    
    public func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    public func loggout() throws {
        try Auth.auth().signOut()
    }
}
