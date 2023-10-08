//
//  Order.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/10/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct OrderReference: CodeIdentifiable {
    @DocumentID var id: String?
    var userId: String
    var barberId: String
    var createdAt: Timestamp
    var deletedAt: Timestamp?
}

struct Order: CodeIdentifiable {
    @DocumentID var id: String?
    var userId: String
    var barberId: String
    let fade: UInt?
    let beard: UInt?
    let hairdryer: UInt?
    let razor: UInt?
    let scissors: UInt?
    let straightener: UInt?
    let atHome: UInt?
    
    var totalPrice: UInt
    
    var intervals: [OrderInterval]?
    var confirmedInterval: OrderInterval?
}

struct OrderInterval: Codable {
    var from: Timestamp
    var to: Timestamp
    
    var timeString: String {
        return "\(from.dateValue().getFormattedHour()) - \(to.dateValue().getFormattedDate())"
    }
}
