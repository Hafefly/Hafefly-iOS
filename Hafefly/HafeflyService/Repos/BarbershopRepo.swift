//
//  BarbershopRepo.swift
//  Hafefly
//
//  Created by Samy Mehdid on 1/10/2023.
//

import Foundation

class BarbershopRepo: FirebaseFirestore {
    
    static let shared = BarbershopRepo(.barbershops)
    
    func listBarbershops(_ barbershops: @escaping ([Barbershop]) -> Void, failure: @escaping (String) -> Void) {
        self.readDocuments(success: barbershops, failure: failure)
    }
    
    func listVipBarbershops(_ barbershops: @escaping ([Barbershop]) -> Void, failure: @escaping (String) -> Void) {
        self.queryDocuments(query: ("vip", true), success: barbershops, failure: failure)
    }
    
    func getBarbershop(barbershopID: String, success: @escaping (Barbershop) -> Void, failure: @escaping (String) -> Void) {
        self.readDocument(documentID: barbershopID, success: success, failure: failure)
    }
}
