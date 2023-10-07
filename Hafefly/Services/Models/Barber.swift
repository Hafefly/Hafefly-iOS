//
//  Barber.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct Barber: CodeIdentifiable {
    
    @DocumentID var id: String?
    var barbershopUID: String
    var barbershopName: String
    var profileImage: String?
    var firstname: String
    var lastname: String
    var bio: String
    var age: UInt
    var experience: UInt
    var haircutsDone: UInt
    var instagram: String
    var isAvailableToHome: Bool
    var phoneNumber: String
    var province: String
    var rating: Double
    var verified: Bool
    var workingHours: WorkingHours
    var reviews: [Review]?
}

struct Review: Identifiable, Codable {
    let id: UInt
    let message: String
    let username: String
    let rating: Double?
}
