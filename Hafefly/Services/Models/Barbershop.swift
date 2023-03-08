//
//  Barbershop.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import Foundation
import CoreLocation

struct Barbershop {
    let id: Int
    let name: String
    let image: String
    let town: String
    let rating: Double
    let workingHours: WorkingHours
    let pricing: Pricing
    let coordinate: Coordinate
    let vip: Bool
    let barbers: [Barber]
    
    var position: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)

    }
    
    static let barbershops = [
        Barbershop(id: 1, name: "El Baraka", image: "Le Majestic", town: "Alger", rating: 4.3, workingHours: WorkingHours(opening: Date(), closing: Date()), pricing: Pricing(fade: 800, beard: 500, hairdryer: 300, razor: 350, scissors: 500, strightener: 300), coordinate: Coordinate(latitude: 36.7508, longitude: 3.0588), vip: false, barbers: [Barber(id: 1, barbershopID: 1, barbershopName: "El Baraka", name: "Ahmed", bio: "Expert in fades and beard trims", age: 28, experience: 5, haircutsDone: 1000, instagram: "@ahmed_barber", isAvailableHome: true, phone: "123-456-7890", province: "Algiers", rating: 4.5, verified: true, workingHours: WorkingHours(opening: Date(), closing: Date()))]),
        
        Barbershop(id: 2, name: "New Style", image: "Le Majestic", town: "Bab Ezzouar", rating: 4.2, workingHours: WorkingHours(opening: Date(), closing: Date()), pricing: Pricing(fade: 750, beard: 450, hairdryer: 250, razor: 300, scissors: 450, strightener: 250), coordinate: Coordinate(latitude: 36.7229, longitude: 3.1821), vip: true, barbers: [Barber(id: 2, barbershopID: 2, barbershopName: "New Style", name: "Karim", bio: "Specializes in scissor cuts and razor fades", age: 35, experience: 10, haircutsDone: 2000, instagram: "@karim_barber", isAvailableHome: false, phone: "123-456-7890", province: "Algiers", rating: 4.9, verified: true, workingHours: WorkingHours(opening: Date(), closing: Date()))]),
        
        Barbershop(id: 3, name: "Le Roi de la Coiffure", image: "Le Majestic", town: "Ben Aknoun", rating: 4.7, workingHours: WorkingHours(opening: Date(), closing: Date()), pricing: Pricing(fade: 700, beard: 400, hairdryer: 200, razor: 250, scissors: 400, strightener: 200), coordinate: Coordinate(latitude: 36.7576, longitude: 2.9906), vip: false, barbers: [Barber(id: 3, barbershopID: 3, barbershopName: "Le Roi de la Coiffure", name: "Said", bio: "Master of all hair types and textures", age: 30, experience: 6, haircutsDone: 1500, instagram: "@said_barber", isAvailableHome: true, phone: "123-456-7890", province: "Algiers", rating: 4.7, verified: true, workingHours: WorkingHours(opening: Date(), closing: Date()))]),
        
        Barbershop(id: 4, name: "Style & Coiffure", image: "Le Majestic", town: "Bir Mourad Raïs", rating: 4.5, workingHours: WorkingHours(opening: Date(), closing: Date()), pricing: Pricing(fade: 750, beard: 450, hairdryer: 250, razor: 300, scissors: 450, strightener: 250), coordinate: Coordinate(latitude: 36.7289, longitude: 3.0625), vip: true, barbers: [Barber(id: 4, barbershopID: 4, barbershopName: "Style & Coiffure", name: "Omar", bio: "The go-to barber for beard grooming and hot towel shaves", age: 32, experience: 8, haircutsDone: 1800, instagram: "@omar_barber", isAvailableHome: false, phone: "123-456-7890", province: "Algiers", rating: 4.8, verified: true, workingHours: WorkingHours(opening: Date(), closing: Date()))]),
        
        Barbershop(id: 5, name: "Moustache", image: "Le Majestic", town: "Bordj El Kiffan", rating: 4.4, workingHours: WorkingHours(opening: Date(), closing: Date()), pricing: Pricing(fade: 700, beard: 400, hairdryer: 200, razor: 250, scissors: 400, strightener: 200), coordinate: Coordinate(latitude: 36.7498, longitude: 3.2112), vip: false, barbers: [Barber(id: 5, barbershopID: 5, barbershopName: "Moustache", name: "Hassan", bio: "Creative and skilled barber specializing in trendy hairstyles", age: 26, experience: 4, haircutsDone: 800, instagram: "@hassan_barber", isAvailableHome: false, phone: "123-456-7890", province: "Algiers", rating: 4.2, verified: true, workingHours: WorkingHours(opening: Date(), closing: Date()))]),
        
        Barbershop(id: 6, name: "Le Barbier d'Alger", image: "Le Majestic", town: "Bouzareah", rating: 4.8, workingHours: WorkingHours(opening: Date(), closing: Date()), pricing: Pricing(fade: 800, beard: 500, hairdryer: 300, razor: 350, scissors: 500, strightener: 300), coordinate: Coordinate(latitude: 36.7537, longitude: 3.0257), vip: true, barbers: [Barber(id: 6, barbershopID: 6, barbershopName: "Le Barbier d'Alger", name: "Ali", bio: "The barber with the magic hands, skilled in all types of haircuts", age: 40, experience: 12, haircutsDone: 2500, instagram: "@ali_barber", isAvailableHome: true, phone: "123-456-7890", province: "Algiers", rating: 5.0, verified: true, workingHours: WorkingHours(opening: Date(), closing: Date()))]),
        
        Barbershop(id: 7, name: "Babylone Coiffure", image: "Le Majestic", town: "Chéraga", rating: 4.3, workingHours: WorkingHours(opening: Date(), closing: Date()), pricing: Pricing(fade: 300, beard: 100, hairdryer: 50, razor: 50, scissors: 50, strightener: 50), coordinate: Coordinate(latitude: 36.7289, longitude: 2.9307), vip: true, barbers: [Barber(id: 7, barbershopID: 7, barbershopName: "Babylone Coiffure", name: "Ali", bio: "The barber with the magic hands, skilled in all types of haircuts", age: 40, experience: 12, haircutsDone: 2500, instagram: "@ali_barber", isAvailableHome: true, phone: "123-456-7890", province: "Algiers", rating: 5.0, verified: true, workingHours: WorkingHours(opening: Date(), closing: Date()))])
        ]
}

struct Coordinate {
    let latitude: Double
    let longitude: Double
}
