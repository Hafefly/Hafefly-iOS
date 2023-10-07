//
//  Userdb.swift
//  Hafefly
//
//  Created by Samy Mehdid on 30/9/2023.
//

import Foundation
import FirebaseFirestore

class UserRepo {
    static let shared = UserRepo()
    
    let userCollection = Firestore.firestore().collection(HFCollection.users.rawValue)
    
    func userDocument(_ id: String) -> DocumentReference {
        return userCollection.document(id)
    }
    
    func createUser(_ user: HFUser) throws {
        guard let id = user.id else {
            throw URLError(.badURL)
        }
        
        return try userDocument(id).setData(from: user)
    }
    
    func updateUser(_ user: HFUser) throws {
        try self.createUser(user)
    }
    
    func getUser(_ id: String) async throws -> HFUser {
        debugPrint(id)
        debugPrint(try await self.userDocument(id).getDocument().data())
        return try await self.userDocument(id).getDocument(as: HFUser.self)
    }
    
    func setFavoriteBarbershop(_ id: String, barbershopID: String) throws {
        let barbershopRef = DocReference(
            docId: barbershopID,
            createdAt: Timestamp())
        
        try self.userDocument(id).collection(HFCollection.favorites.rawValue).addDocument(from: barbershopRef)
    }
    
    func getUserFavoriteBarbershops(_ id: String) async throws -> [Barbershop] {
        let docIds = try self.decodeDocuments(try await self.userDocument(id).collection(HFCollection.favorites.rawValue).getDocuments(), as: DocReference.self).map { $0.docId }
        
        return try await BarbershopRepo.shared.listBarbershops(withIds: docIds)
    }
    
    func createHaircut(_ id: String, haircutID: String) throws {
        let haircut = DocReference(docId: haircutID, createdAt: Timestamp())
        
        try self.userDocument(id).collection(HFCollection.history.rawValue).addDocument(from: haircut)
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
