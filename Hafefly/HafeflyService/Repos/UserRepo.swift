//
//  Userdb.swift
//  Hafefly
//
//  Created by Samy Mehdid on 30/9/2023.
//

import Foundation

class UserRepo: FirebaseFirestore {
    
    static var shared: UserRepo {
        return UserRepo(self.db.collection(HFCollection.users.rawValue))
    }
    
    func getUser(UserID: String, success: @escaping (HFUser) -> Void, failure: @escaping (String) -> Void) {
        self.readDocument(documentID: UserID, success: success, failure: failure)
    }
    
    func createUser(user: HFUser, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        self.addDocument(data: user.toDictionary(), success: success, failure: failure)
    }
}
