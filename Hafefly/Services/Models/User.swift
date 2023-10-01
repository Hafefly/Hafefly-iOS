//
//  User.swift
//  Hafefly
//
//  Created by Samy Mehdid on 12/3/2023.
//

import Foundation
import FirebaseAuth

struct HFUser: Identifiable, Codable {
    let id: String
    let firstname: String
    let lastname: String
    let profileImage: String?
    let phone: String?
    let email: String?
    let instagram: String?
    let province: String
    let haircutsDone: UInt
    let age: UInt
    let vip: Bool
    
    init(id: String, firstname: String, lastname: String, profileImage: String?, phone: String?, email: String?, instagram: String?, province: String, haircutsDone: UInt, age: UInt, vip: Bool) {
        self.id = id
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
    
    static let user = HFUser(id: "0", firstname: "samy", lastname: "mehdid", profileImage: nil, phone: "+213540408051", email: "samy.mhd16@gmail.com", instagram: "@samyinavoid", province: "Algiers", haircutsDone: 5, age: 21, vip: true)
    
    func toDictionary() -> [String: Any] {
        let mirror = Mirror(reflecting: self)
        var dictionary = [String: Any]()
        
        for case let (label?, value) in mirror.children {
            dictionary[label] = value
        }
        
        return dictionary
    }
}
