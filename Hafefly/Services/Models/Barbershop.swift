//
//  Barbershop.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import Foundation
import CoreLocation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct Barbershop: Equatable, CodeIdentifiable {
    static func == (lhs: Barbershop, rhs: Barbershop) -> Bool {
        return lhs.id != rhs.id
    }
    
    @DocumentID var id: String?
    var name: String
    var imageUrl: String?
    var town: String
    var rating: Double
    var workingHours: WorkingHours
    var pricing: Pricing?
    var coordinate: Coordinate
    var vip: Bool
    var barbers: [Barber]?
    
    var isOpen: Bool {
        let now = Date()
        
        return now >= workingHours.openingDate || now <= workingHours.openingDate
    }
    
    var position: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
}
