//
//  HaircutsHistory.swift
//  Hafefly
//
//  Created by Samy Mehdid on 12/3/2023.
//

import Foundation

struct HaircutHistory: Identifiable, Codable {
    
    typealias Interval = WorkingHours
    
    let id: UInt
    let username: String
    let barber: Barber
    let barbershop: Barbershop
    let price: UInt
    let time: Interval
    let haircut: [Haircut]
}
