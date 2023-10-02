//
//  Firestore.swift
//  Hafefly
//
//  Created by Samy Mehdid on 30/9/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

enum HFCollection: String {
    case users
    case barbers
    case barbershops
    case history
    case reviews
}

protocol CodeIdentifiable: Codable, Identifiable {
    var id: String? { get }
}

class FirebaseFirestore {
    private let db = Firestore.firestore()
    
    let collection: String
    
    init(_ collection: HFCollection) {
        self.collection = collection.rawValue
    }
    
    func addDocument<T: CodeIdentifiable>(_ data: T, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        let ref: CollectionReference = db.collection(collection)
        do {
            success(try ref.addDocument(from: data).documentID)
        } catch {
            failure(error.localizedDescription)
        }
    }
    
    func updateDocument<T: CodeIdentifiable>(_ data: T, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        if let docId = data.id {
            let ref: DocumentReference = db.collection(collection).document(docId)
            do {
                try ref.setData(from: data)
                
                success(docId)
            } catch {
                failure(error.localizedDescription)
            }
        }
    }
    
    func readDocuments<T: CodeIdentifiable>(success: @escaping ([T]) -> Void, failure: @escaping (String) -> Void) {
        db.collection(collection).getDocuments { query, error in
            guard error == nil else {
                failure(error!.localizedDescription)
                return
            }
            
            guard let query = query else {
                failure("No Document found")
                return
            }
            
            var documents = [T]()
            
            for document in query.documents {
                do {
                    documents.append(try document.data(as: T.self))
                } catch {
                    debugPrint(document.data())
                    // Handle any decoding errors
                    print("Error decoding document with ID: \(document.documentID), Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func readDocument<T: CodeIdentifiable>(documentID: String, success: @escaping (T) -> Void, failure: @escaping (String) -> Void) {
        debugPrint(documentID)
        db.collection(collection).document(documentID).getDocument(as: T.self) { result in
            switch result {
            case .success(let doc):
                success(doc)
            case .failure(let error):
                debugPrint(result)
                failure(error.localizedDescription)
            }
        }
    }
    
    func queryDocuments<T: CodeIdentifiable>(query: (String, Any), success: @escaping([T]) -> Void, failure: @escaping (String) -> Void) {
        db.collection(collection).whereField(query.0, isEqualTo: query.1)
            .getDocuments { query, error in
                guard error == nil else {
                    failure(error!.localizedDescription)
                    return
                }
                
                guard let query = query else {
                    failure("No Document found")
                    return
                }
                
                var documents = [T]()
                
                for document in query.documents {
                    do {
                        documents.append(try document.data(as: T.self))
                    } catch {
                        debugPrint(document.data())
                        // Handle any decoding errors
                        print("Error decoding document with ID: \(document.documentID), Error: \(error.localizedDescription)")
                    }
                }
                
                success(documents)
            }
    }
}
