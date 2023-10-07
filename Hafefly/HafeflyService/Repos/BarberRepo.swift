//
//  BarberRepo.swift
//  Hafefly
//
//  Created by Samy Mehdid on 1/10/2023.
//

import Foundation
import FirebaseFirestore

class BarberRepo {
    
    static let shared = BarberRepo()
    
    private let barbersCollection = Firestore.firestore().collection(HFCollection.barbers.rawValue)
    
    func getBarber(_ id: String) async throws -> Barber {
        return try await barbersCollection.document(id).getDocument(as: Barber.self)
    }
    
    func getBarbers() async throws -> [Barber] {
        return try self.decodeDocuments(try await barbersCollection.getDocuments(), as: Barber.self)
    }
    
    func getBarbersForBarbershop(withIds ids: [String]) async throws -> [Barber] {
        guard !ids.isEmpty else {
            return []
        }
        
        return try self.decodeDocuments(try await barbersCollection.whereField(FieldPath.documentID(), in: ids).getDocuments(), as: Barber.self)
    }
    
    func decodeDocuments<T: Decodable>(_ snapshots: QuerySnapshot, as type: T.Type) throws -> [T] {
        var decodedData = [T]()
                
        for document in snapshots.documents {
            if let data = try? document.data(as: type) {
                decodedData.append(data)
            }
        }
                
        return decodedData
    }
}
