//
//  BarberRepo.swift
//  Hafefly
//
//  Created by Samy Mehdid on 1/10/2023.
//

import Foundation

class BarberRepo: FirebaseFirestore {
    
    static let shared = BarberRepo(.barbers)
    
    func getBarber(barberID id: String, success: @escaping (Barber) -> Void, failure: @escaping (String) -> Void) {
        self.readDocument(documentID: id, success: success, failure: failure)
    }
    
    func getBarbers(success: @escaping ([Barber]) -> Void, failure: @escaping (String) -> Void) {
        self.readDocuments(success: success, failure: failure)
    }
    
    func getBarbersForBarbershop(barbershopID id: String, success: @escaping ([Barber]) -> Void, failure: @escaping (String) -> Void) {
        self.queryDocuments(query: ("barbershopUID", id), success: success, failure: failure)
    }
}
