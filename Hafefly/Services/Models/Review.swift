//
//  Review.swift
//  Hafefly
//
//  Created by Samy Mehdid on 7/10/2023.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct Review: CodeIdentifiable {
    @DocumentID var id: String?
    var message: String?
    var rating: Double
    
    var user: HFUser?
    var barber: Barber?
}

struct ReviewReference: CodeIdentifiable {
    @DocumentID var id: String?
    var barberId: String
    var userId: String
    var createdAt: Timestamp
    var deletedAt: Timestamp?
}
