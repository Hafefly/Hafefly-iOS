//
//  WorkingHours.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import Foundation

struct WorkingHours: Codable {
    let opening: String
    let closing: String
    
    var openingDate: Date {
        return opening.parseDate ?? Date()
    }
    
    var closingDate: Date {
        return closing.parseDate ?? Date()
    }
}
