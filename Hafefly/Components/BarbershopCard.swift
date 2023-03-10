//
//  BarbershopCard.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import SwiftUI

struct BarbershopCard: View {
    
    let barbershop: Barbershop
    
    @State var isFavorite: Bool = false
    
    init(barbershop: Barbershop, isFavorite: Bool = true) {
        self.barbershop = barbershop
        self._isFavorite = State(initialValue: isFavorite)
    }
    
    var body: some View {
        ZStack(alignment: .trailing){
            Image(barbershop.image)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .overlay(LinearGradient(colors: [.favoriteBlue, .clear], startPoint: .leading, endPoint: .trailing))
            HStack {
                VStack(alignment: .leading){
                    VStack(alignment: .leading, spacing: 2){
                        Text(barbershop.name)
                            .font(.white, Font.HafeflyRubik.medium, 22)
                        HStack{
                            Image("ic_gps")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(width: 14)
                            Text(barbershop.town)
                                .font(.white, Font.HafeflyRubik.regular, 16)
                        }.foregroundColor(.white)
                    }
                    Spacer()
                    HStack{
                        Image("ic_star")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.yellow)
                            .frame(width: 18, height: 18)
                        Text(barbershop.rating.rating())
                            .font(.white, Font.HafeflyRubik.bold, 18)
                    }
                }
                Spacer()
                VStack{
                    Button {
                        isFavorite.toggle()
                    } label: {
                        Image("ic_heart")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 24, height: 24)
                            .padding(6)
                            .foregroundColor(isFavorite ? Color.white : Color.red)
                            .background(Circle().fill(isFavorite ? Color.red : Color.white).shadow(color: .black.opacity(0.6), radius: 3, x: 4, y: 4))
                    }
                    Button {
                        //
                    } label: {
                        Image("ic_location")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .padding(8)
                            .background(Circle().fill(LinearGradient(colors: [.hafeflyLightBlue, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)).shadow(color: .black.opacity(0.6), radius: 3, x: 4, y: 4))
                    }
                }
            }
            .frame(height: 80)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .background(Color.favoriteBlue)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 2, x: 2, y: 2)
    }
}

struct BarbershopCard_Previews: PreviewProvider {
    static var previews: some View {
        BarbershopCard(barbershop: Barbershop.barbershops[0], isFavorite: true)
    }
}
