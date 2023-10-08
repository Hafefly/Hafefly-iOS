//
//  HaircutCard.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/10/2023.
//

import SwiftUI

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
