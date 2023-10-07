//
//  ReviewRepo.swift
//  Hafefly
//
//  Created by Samy Mehdid on 7/10/2023.
//

import Foundation
import FirebaseFirestore

class ReviewRepo {
    
    static let shared = ReviewRepo()
    
    private let reviewCollection = Firestore.firestore().collection(HFCollection.reviews.rawValue)
    
    func getReviews(withIds ids: [String]) async throws -> [Review] {
        guard !ids.isEmpty else {
            return []
        }
        
        return try self.decodeDocuments(try await reviewCollection.whereField(FieldPath.documentID(), in: ids).getDocuments(), as: Review.self)
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
