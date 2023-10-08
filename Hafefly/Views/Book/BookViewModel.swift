//
//  BookViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/10/2023.
//

import Foundation
import HFNavigation

extension BookView {
    class Model: ObservableObject {
        
        func createOrder(barberId: String?, haircuts: [String: Any], totalPrice: UInt) {
            guard
                let userId = FirebaseAuth.shared.getUserId(),
                let barberId = barberId
            else {
                #warning("show failure banner")
                return
            }
            
            let fade = haircuts["fade"] as? UInt
            let beard = haircuts["beard"] as? UInt
            let hairdryer = haircuts["hairdryer"] as? UInt
            let razor = haircuts["razor"] as? UInt
            let scissors = haircuts["scissors"] as? UInt
            let straightener = haircuts["straightener"] as? UInt
            let atHome = haircuts["atHome"] as? UInt
            
            let order = Order(userId: userId, barberId: barberId, fade: fade, beard: beard, hairdryer: hairdryer, razor: razor, scissors: scissors, straightener: straightener, atHome: atHome, totalPrice: totalPrice)
            
            do {
                try OrderRepo.shared.createOrderReference(order: order)
                
                NavigationCoordinator.pushScreen(AppointementView())
            } catch {
                #warning("show failure banner")
            }
        }
    }
}
