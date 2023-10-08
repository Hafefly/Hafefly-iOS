//
//  OrderRepo.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/10/2023.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

class OrderRepo {
    static let shared = OrderRepo()
    
    private let ordersCollection = Firestore.firestore().collection(HFCollection.orders.rawValue)
    
    func createOrderReference(order: Order) throws {
        let referenceId = try createOrder(order: order)
        
        let ref = OrderReference(userId: order.userId, barberId: order.barberId, createdAt: Timestamp())
        
        try UserRepo.shared.createOrderReference(ref: ref, referenceId: referenceId)
        try BarberRepo.shared.createOrderReference(ref: ref, referenceId: referenceId)
    }
    
    private func createOrder(order: Order) throws -> String {
        let reference = ordersCollection.document()
        try reference.setData(from: order)
        return reference.documentID
    }
    
    func getOrders(withIds ids: [String]) async throws -> [Order] {
        guard !ids.isEmpty else {
            return []
        }
        
        var orders = try self.decodeDocuments(try await ordersCollection.whereField(FieldPath.documentID(), in: ids).getDocuments(), as: Order.self)
        
        return orders
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
