//
//  User.swift
//  Hafefly
//
//  Created by Samy Mehdid on 12/3/2023.
//

import Foundation

struct User: Identifiable {
    let id: UInt
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
    
    static let user = User(id: 0, firstname: "samy", lastname: "mehdid", profileImage: nil, phone: "+213540408051", email: "samy.mhd16@gmail.com", instagram: "@samyinavoid", province: "Algiers", haircutsDone: 5, age: 21, vip: true)
}
