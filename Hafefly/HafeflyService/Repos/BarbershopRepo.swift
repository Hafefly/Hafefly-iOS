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
    
    private let barbershopsCollection = Firestore.firestore().collection(HFCollection.barbershops.rawValue)
    
    private func barbershopDocument(_ id: String) -> DocumentReference {
        return barbershopsCollection.document(id)
    }
    
    private func barbersCollection(_ id: String) -> CollectionReference {
        return barbershopDocument(id).collection(HFCollection.barbers.rawValue)
    }
    
    func listBarbershops() async throws -> [Barbershop] {
        var barbershops = try self.decodeDocuments(try await barbershopsCollection.getDocuments(), as: Barbershop.self)
        
        for index in 0..<barbershops.count {
            barbershops[index].barbers = try await self.getBarbershopBarbers(barbershops[index].id!)
        }
        
        return barbershops
    }
    
    func listBarbershops(withIds ids: [String]) async throws -> [Barbershop] {
        guard !ids.isEmpty else {
            return []
        }
        
        var barbershops = try self.decodeDocuments(try await barbershopsCollection.whereField(FieldPath.documentID(), in: ids).getDocuments(), as: Barbershop.self)
        
        for index in 0..<barbershops.count {
            barbershops[index].barbers = try await self.getBarbershopBarbers(barbershops[index].id!)
        }
        
        return barbershops
    }
    
    func listVipBarbershops() async throws -> [Barbershop] {
        var barbershops = try self.decodeDocuments(try await barbershopsCollection.whereField("vip", isEqualTo: true).getDocuments(), as: Barbershop.self)
        
        for index in 0..<barbershops.count {
            barbershops[index].barbers = try await self.getBarbershopBarbers(barbershops[index].id!)
        }
        
        return barbershops
    }
    
    func getBarbershop(_ id: String) async throws -> Barbershop {
        var barbershop = try await barbershopsCollection.document(id).getDocument(as: Barbershop.self)
        barbershop.barbers = try await self.getBarbershopBarbers(id)
        return barbershop
    }
    
//    func queryBarbershops(for text: String) async throws -> [Barbershop] {
//        return try self.decodeDocuments(try await barbershopsCollection.where.getDocuments(), as: Barbershop.self)
//    }
    
    func getBarbershopBarbers(_ id: String) async throws -> [Barber] {
        let docIds = try self.decodeDocuments(try await self.barbersCollection(id).getDocuments(), as: DocReference.self).map { $0.docId }
        
        return try await BarberRepo.shared.getBarbersForBarbershop(withIds: docIds)
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
