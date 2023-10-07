//
//  Category.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import SwiftUI

enum Category: String, CaseIterable, Identifiable {
    case favorites
    case highestRatings
    case nearby
    
    var id: UUID { UUID() }
    
    var icon: String {
        switch self {
        case .favorites:
            return "ic_heart"
        case .highestRatings:
            return "ic_star"
        case .nearby:
            return "ic_nearby"
        }
    }
    
    var color: Color {
        switch self {
        case .favorites:
            return .red
        case .highestRatings:
            return .yellow
        case .nearby:
            return .blue
        }
    }
}
