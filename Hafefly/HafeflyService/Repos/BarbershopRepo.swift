//
//  BarbershopRepo.swift
//  Hafefly
//
//  Created by Samy Mehdid on 1/10/2023.
//

import Foundation
import FirebaseFirestore

class BarbershopRepo {
    
    static let shared = BarbershopRepo()
    
    let barbershopsCollection = Firestore.firestore().collection(HFCollection.barbershops.rawValue)
    
    func listBarbershops() async throws -> [Barbershop] {
        return try self.decodeDocuments(try await barbershopsCollection.getDocuments(), as: Barbershop.self)
    }
    
    func listBarbershops(withIds ids: [String]) async throws -> [Barbershop] {
        guard !ids.isEmpty else {
            return []
        }
        return try self.decodeDocuments(try await barbershopsCollection.whereField(FieldPath.documentID(), in: ids).getDocuments(), as: Barbershop.self)
    }
    
    func listVipBarbershops() async throws -> [Barbershop] {
        return try self.decodeDocuments(try await barbershopsCollection.whereField("vip", isEqualTo: true).getDocuments(), as: Barbershop.self)
    }
    
//    func queryBarbershops(for text: String) async throws -> [Barbershop] {
//        return try self.decodeDocuments(try await barbershopsCollection.where.getDocuments(), as: Barbershop.self)
//    }
    
    func getBarbershop(barbershopID: String) async throws -> Barbershop {
        return try await barbershopsCollection.document(barbershopID).getDocument(as: Barbershop.self)
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
