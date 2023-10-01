//
//  Firestore.swift
//  Hafefly
//
//  Created by Samy Mehdid on 30/9/2023.
//

import Foundation
import FirebaseFirestore

enum HFCollection: String {
    case users
    case barbers
    case barbershops
    case history
    case reviews
}

class FirebaseFirestore {
    
    public let db = Firestore.firestore()
    
    private let collection: CollectionReference
    
    init(_ collection: CollectionReference) {
        self.collection = collection
    }
    
    func addDocument(data: [String: Any], success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        var ref: DocumentReference? = nil
        
        ref = collection.addDocument(data: data) { error in
            if let error = error {
                failure(error.localizedDescription)
            } else if let ref = ref {
                success(ref.documentID)
            }
        }
    }
    
    func readDocuments<T: Codable>(success: @escaping ([T]) -> Void, failure: @escaping (String) -> Void) {
        db.collection.getDocuments { query, error in
            guard error == nil else {
                failure(error!.localizedDescription)
                return
            }
            
            var documents = [T]()
            
            guard let query = query else {
                failure("No Document found")
                return
            }
            
            for document in query.documents {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: [])
                    let model = try JSONDecoder().decode(T.self, from: jsonData)
                    documents.append(model)
                } catch {
                    failure("Error decoding document: \(error.localizedDescription)")
                    return
                }
            }
            
            success(documents)
        }
    }
    
    func readDocument<T: Codable>(documentID: String, success: @escaping (T) -> Void, failure: @escaping (String) -> Void) {
        db.collection.document(documentID).getDocument { doc, error in
            guard error == nil else {
                failure(error!.localizedDescription)
                return
            }
            
            guard let doc = doc, doc.exists else {
                failure("No Document found")
                return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                let document = try JSONDecoder().decode(T.self, from: jsonData)
                success(document)
            } catch {
                failure("Error decoding document: \(error.localizedDescription)")
                return
            }
        }
    }
    
    func queryDocuments<T: Codable>(query: (String, Any), success: @escaping([T]) -> Void, failure: @escaping (String) -> Void) {
        db.collection.whereField(query.0, isEqualTo: query.1)
            .getDocuments { query, error in
                guard error == nil else {
                    failure(error!.localizedDescription)
                    return
                }
                
                var documents = [T]()
                
                guard let query = query else {
                    failure("No Document found")
                    return
                }
                
                for document in query.documents {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: [])
                        let model = try JSONDecoder().decode(T.self, from: jsonData)
                        documents.append(model)
                    } catch {
                        failure("Error decoding document: \(error.localizedDescription)")
                        return
                    }
                }
                
                success(documents)
            }
    }
}
