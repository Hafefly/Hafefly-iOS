//
//  User.swift
//  Hafefly
//
//  Created by Samy Mehdid on 12/3/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift

struct HFUser: CodeIdentifiable {
    
    @DocumentID var id: String?
    var firstname: String
    var lastname: String
    var profileImage: String?
    var phone: String?
    var email: String?
    var instagram: String?
    var province: String
    var haircutsDone: UInt
    var age: UInt
    var vip: Bool
    
    init(firstname: String, lastname: String, profileImage: String?, phone: String?, email: String?, instagram: String?, province: String, haircutsDone: UInt, age: UInt, vip: Bool) {
        self.firstname = firstname
        self.lastname = lastname
        self.profileImage = profileImage
        self.phone = phone
        self.email = email
        self.instagram = instagram
        self.province = province
        self.haircutsDone = haircutsDone
        self.age = age
        self.vip = vip
    }
    
    init(user: User) {
        self.id = user.uid
        self.firstname = user.displayName ?? ""
        self.lastname = user.displayName ?? ""
        self.email = user.email
        self.phone = user.phoneNumber
        self.profileImage = user.photoURL?.absoluteString
        self.instagram = nil
        self.province = "Algiers"
        self.haircutsDone = 0
        self.age = 18
        self.vip = false
    }
}
