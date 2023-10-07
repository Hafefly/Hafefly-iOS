//
//  BarberRepo.swift
//  Hafefly
//
//  Created by Samy Mehdid on 1/10/2023.
//

import Foundation
import FirebaseFirestore

class BarberRepo: FirebaseFirestore {
    
    static var collectionRef: CollectionReference = Firestore.firestore().collection(HFCollection.barbers.rawValue)
    
    static func getBarber(barberID id: String, success: @escaping (Barber) -> Void, failure: @escaping (String) -> Void) {
        BarberRepo(collectionRef).readDocument(documentID: id, success: success, failure: failure)
    }
    
    static func getBarbers(success: @escaping ([Barber]) -> Void, failure: @escaping (String) -> Void) {
        BarberRepo(collectionRef).readDocuments(success: success, failure: failure)
    }
    
    static func getBarbersForBarbershop(barbershopID id: String, success: @escaping ([Barber]) -> Void, failure: @escaping (String) -> Void) {
        BarberRepo(collectionRef).queryDocuments(query: ("barbershopUID", id), success: success, failure: failure)
    }
}
