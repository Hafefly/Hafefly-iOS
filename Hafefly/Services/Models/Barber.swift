//
//  Barber.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import Foundation

struct Barber: Identifiable, Codable {
    let id: UInt
    let barbershopID: UInt
    let barbershopName: String
    let profileImage: String?
    let name: String
    let bio: String
    let age: UInt
    let experience: UInt
    let haircutsDone: UInt
    let instagram: String
    let isAvailableHome: Bool
    let phone: String
    let province: String
    let rating: Double
    let verified: Bool
    let workingHours: WorkingHours
    let reviews: [Review]
}

struct Review: Identifiable, Codable {
    let id: UInt
    let message: String
    let username: String
    let rating: Double?
}
