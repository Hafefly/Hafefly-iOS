//
//  Category.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import SwiftUI

struct Category {
    let uuid = UUID()
    let icon: String
    let name: String
    let color: Color
    let barbershops: [Barbershop]
    
    var itemsCount: Int {
        return barbershops.count
    }
    
    static let categories = [
        Category(icon: "ic_heart", name: "Favorites", color: .red, barbershops: []),
        Category(icon: "ic_star", name: "Highest Rating", color: .yellow, barbershops: []),
        Category(icon: "ic_location", name: "Nearby", color: .blue, barbershops: [])
    ]
}
