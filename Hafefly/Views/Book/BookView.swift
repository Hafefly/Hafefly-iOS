//
//  BookView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 12/3/2023.
//

import SwiftUI

struct BookView: View {
    
    @StateObject private var model = Model()
    
    private let barbershop: Barbershop
    private let barber: Barber
    
    @State private var haircuts = [Haircut]() {
        willSet {
            totalPrice = getTotalPrice(newValue)
        }
    }
    
    @State private var totalPrice: UInt = 0
    
    init(_ barbershop: Barbershop, barber: Barber) {
        self.barbershop = barbershop
        self.barber = barber
    }
    
    var body: some View {
        ViewLayout {
            HeaderView(title: "book".localized)
        } content: { edges in
            VStack{
                ScrollView(showsIndicators: false){
                    VStack(spacing: 28){
                        ForEach(Haircut.allCases, id: \.hashValue) { haircut in
                            if let pricing = barbershop.pricing {
                                HaircutCard(haircut, pricing: pricing){ isSelected in
                                    if isSelected {
                                        haircuts.removeAll { $0.hashValue == haircut.hashValue }
                                    } else {
                                        haircuts.append(haircut)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.vertical)
                }
                
                HafeflyButton(disabled: totalPrice == 0, foregroundColor: .orange) {
                    model.createOrder(barbershop: barbershop, barberId: barber.id, haircuts: haircutsToOrder(haircuts: haircuts), totalPrice: totalPrice)
                } label: {
                    if totalPrice != 0 {
                        Text("\("book_for".localized): \(totalPrice.toString)")
                            .font(.white, Font.HafeflyRubik.bold, 22)
                    } else {
                        Text("choose_to_book".localized)
                            .font(.white, Font.HafeflyRubik.bold, 22)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    private func getTotalPrice(_ haircuts: [Haircut]) -> UInt {
        var price: UInt = 0
        for haircut in haircuts {
            if let pricing = barbershop.pricing {
                price += haircut.pricing(pricing)
            }
        }
        
        return price
    }
    
    private func haircutsToOrder(haircuts: [Haircut]) -> [String: Any] {
        var dict: [String: Any] = [:]
        for haircut in haircuts {
            if let pricing = barbershop.pricing {
                dict[haircut.rawValue] = haircut.pricing(pricing)
            }
        }
        return dict
    }
}
