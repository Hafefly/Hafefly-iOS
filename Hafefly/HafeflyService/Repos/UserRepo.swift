//
//  Userdb.swift
//  Hafefly
//
//  Created by Samy Mehdid on 30/9/2023.
//

import Foundation

class UserRepo: FirebaseFirestore {
    
    static var shared = UserRepo(.users)
    
    func getUser(UserID: String, success: @escaping (HFUser) -> Void, failure: @escaping (String) -> Void) {
        self.readDocument(documentID: UserID, success: success, failure: failure)
    }
    
    func createUser(_ user: HFUser, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        self.addDocument(user, success: success, failure: failure)
    }
    
    func updateUser(_ user: HFUser, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        self.updateDocument(user, success: success, failure: failure)
    }
}
