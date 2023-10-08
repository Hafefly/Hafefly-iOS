//
//  BookView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 12/3/2023.
//

import SwiftUI

struct BookView: View {
    
    @StateObject private var model = Model()
    
    private let pricing: Pricing
    private let barber: Barber
    
    @State private var haircuts = [Haircut]() {
        willSet {
            totalPrice = getTotalPrice(newValue)
        }
    }
    
    @State private var totalPrice: UInt = 0
    
    init(_ pricing: Pricing, barber: Barber) {
        self.pricing = pricing
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
                            HaircutCard(haircut, pricing: pricing){ isSelected in
                                if isSelected {
                                    haircuts.removeAll { $0.hashValue == haircut.hashValue }
                                } else {
                                    haircuts.append(haircut)
                                }
                            }
                        }
                    }
                    .padding(.vertical)
                }
                
                HafeflyButton(disabled: totalPrice == 0, foregroundColor: .orange) {
                    model.createOrder(barberId: barber.id, haircuts: haircutsToOrder(haircuts: haircuts), totalPrice: totalPrice)
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
            price += haircut.pricing(pricing)
        }
        
        return price
    }
    
    private func haircutsToOrder(haircuts: [Haircut]) -> [String: Any] {
        var dict: [String: Any] = [:]
        for haircut in haircuts {
            dict[haircut.rawValue] = haircut.pricing(pricing)
        }
        return dict
    }
}

//struct BookView_Previews: PreviewProvider {
//    static var previews: some View {
//        let barbershop = Barbershop(id: "", name: "fasta", imageUrl: nil, town: "", rating: 0.0, workingHours: WorkingHours(opening: "", closing: ""), pricing: Pricing(fade: 0, beard: 0, hairdryer: 0, razor: 0, scissors: 0, straightener: 0, atHome: 0), coordinate: Coordinate(latitude: 0.0, longitude: 0.0), vip: true, barbers: [Barber(barbershopUID: "", barbershopName: "", firstname: "Kamel", lastname: "Mat", bio: "bio", age: 20, experience: 5, haircutsDone: 5, instagram: "", isAvailableToHome: true, phoneNumber: "", province: "", rating: 4.4, verified: true, workingHours: WorkingHours(opening: "08:00Z", closing: "18:00Z"))])
//        
//        if let pricing = barbershop.pricing, let barber = barbershop.barbers?[0] {
//            BookView(pricing, barber: barber)
//        }
//    }
//}

enum Haircut: String, CaseIterable, Codable {
    case fade
    case razor
    case scissors
    case beard
    case hairdryer
    case straightener
    case atHome
    
    var illustration: String {
        return "ic_\(self.rawValue)"
    }
    
    func pricing(_ pricing: Pricing) -> UInt {
        switch self {
        case .fade:
            return pricing.fade
        case .razor:
            return pricing.razor
        case .scissors:
            return pricing.scissors
        case .beard:
            return pricing.beard
        case .hairdryer:
            return pricing.hairdryer
        case .straightener:
            return pricing.straightener
        case .atHome:
            return pricing.atHome ?? 0
        }
    }
}

struct HaircutCard: View {
    
    @State private var isSelected = false
    
    private let haircut: Haircut
    private let pricing: Pricing
    
    var action: (Bool) -> Void
    
    init(_ haircut: Haircut, pricing: Pricing, action: @escaping (Bool) -> Void) {
        self.haircut = haircut
        self.pricing = pricing
        self.action = action
    }
    
    var body: some View {
        Button {
            action(isSelected)
            isSelected.toggle()
        } label: {
            ZStack{
                HStack{
                    Image(haircut.illustration)
                        .resizable()
                        .frame(width: 28, height: 28)
                    Text(haircut.rawValue)
                        .font(.white, .medium, 20)
                    Spacer()
                    ZStack{
                        Text(haircut.pricing(pricing).toString + " DA")
                            .font(.white, .medium, 18)
                            .frame(minWidth: 70)
                            .frame(height: 28)
                            .background(Color.hafeflyDarkBlue)
                            .cornerRadius(6)
                    }
                }
            }
            .padding(12)
            .background(isSelected ? Color.favoriteBlue.lighter() : Color.favoriteBlue)
            .cornerRadius(12)
            .shadow(color: isSelected ? .favoriteBlue.lighter(by: 10) : .clear, radius: 2)
        }
    }
}
