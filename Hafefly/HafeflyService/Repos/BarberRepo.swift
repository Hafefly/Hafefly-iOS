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
    
    private func reviewsCollection(_ id: String) -> CollectionReference {
        return barbersCollection.document(id).collection(HFCollection.reviews.rawValue)
    }
    
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
    
    func getBarberReviews(for id: String) async throws -> [Review] {
        guard let docIds = try self.decodeDocuments(try await reviewsCollection(id).getDocuments(), as: ReviewReference.self).map({ $0.id }) as? [String] else {
            throw URLError(.unknown)
        }
        
        return try await ReviewRepo.shared.getReviews(withIds: docIds)
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
