//
//  BookView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 12/3/2023.
//

import SwiftUI

struct BookView: View {
    let pricing: Pricing
    
    @State private var haircuts = [Haircut]() {
        willSet {
            totalPrice = getTotalPrice(newValue)
        }
    }
    
    @State private var totalPrice: UInt = 0
    
    init(_ pricing: Pricing) {
        self.pricing = pricing
    }
    
    let gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ViewLayout {
            HeaderView(title: "book".localized)
        } content: { edges in
            VStack{
                ScrollView(showsIndicators: false){
                    LazyVGrid(columns: gridItems, spacing: 20) {
                        ForEach(Haircut.allCases, id: \.hashValue){ haircut in
                            if nil != pricing.atHome {
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
                }
                HafeflyButton(disabled: totalPrice == 0, foregroundColor: .orange) {
                    //
                } label: {
                    if totalPrice != 0 {
                        Text("\("book_for".localized): \(totalPrice.toString)")
                            .font(.white, Font.HafeflyRubik.bold, 22)
                    } else {
                        Text("choose_to_book".localized)
                            .font(.white, Font.HafeflyRubik.bold, 22)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, edges.bottom)
            .padding(.top, edges.top + 16)
        }
    }
    
    private func getTotalPrice(_ haircuts: [Haircut]) -> UInt {
        var price: UInt = 0
        for haircut in haircuts {
            price += haircut.pricing(pricing)
        }
        
        return price
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        if let pricing = Barbershop.barbershops[0].pricing {
            BookView(pricing)
        }
    }
}

enum Haircut: String, CaseIterable {
    case fade
    case razor
    case scissors
    case beard
    case hairdryer
    case straightener
    case atHome
    
    var illustration: String {
        return "ilu_\(self.rawValue)"
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
            ZStack(alignment: .bottom){
                Image(haircut.illustration)
                    .resizable()
                    .frame(width: 112, height: 112)
                    .padding(.top, 20)
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                        Text(haircut.pricing(pricing).toString)
                            .font(.white, Font.HafeflyRubik.medium, 22)
                            .padding(4)
                            .padding(.horizontal, 4)
                            .background(Color.favoriteBlue)
                            .cornerRadius(8)
                    }
                    Spacer()
                    Text(haircut.rawValue)
                        .font(.white, Font.HafeflyRubik.medium, 22)
                        .padding(4)
                        .padding(.horizontal, 4)
                        .background(Color.favoriteBlue)
                        .cornerRadius(8)
                }
                .padding(8)
            }
            .background(isSelected ? Color.favoriteBlue.lighter(by: 10) : Color.favoriteBlue.darker(by: 20))
            .cornerRadius(16)
            .padding(.horizontal)
            .shadow(color: isSelected ? .hafeflyLightBlue : .clear, radius: 10)
        }
    }
}
