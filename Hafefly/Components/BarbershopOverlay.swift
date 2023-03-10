//
//  BarbershopOverlay.swift
//  Hafefly
//
//  Created by Samy Mehdid on 10/3/2023.
//

import SwiftUI

struct BarbershopOverlay: View {
    let barbershop: Barbershop
    
    init(_ barbershop: Barbershop) {
        self.barbershop = barbershop
    }
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 24){
                HStack{
                    VStack(alignment: .leading){
                        HStack{
                            if barbershop.vip {
                                Image("ic_ticket")
                                    .resizable()
                                    .frame(width: 26, height: 22)
                            }
                            Text(barbershop.name)
                                .font(.white, Font.HafeflyRubik.regular, 24)
                        }
                        
                        HStack{
                            HStack{
                                Image("ic_star")
                                Text(barbershop.rating.rating())
                                    .font(.white, Font.HafeflyRubik.bold, 22)
                            }
                            Text(barbershop.isOpen ? "opened".localized : "closed".localized)
                                .font(barbershop.isOpen ? .green : .red, Font.HafeflyRubik.medium, 18)
                                .padding(.horizontal, 8)
                        }
                    }
                    Spacer()
                    Image("ils_razor")
                }
                .padding()
                .background(Color.favoriteBlue)
                .cornerRadius(22)
                
                VStack(alignment: .leading){
                    HStack(spacing: 16){
                        Image("ic_gps")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                        Text(barbershop.town)
                            .font(.white, Font.HafeflyRubik.medium, 26)
                    }
                    
                    HStack(spacing: 16){
                        Image("ic_clock")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                        Text("\(barbershop.workingHours.opening.getFormattedDate())  -  \(barbershop.workingHours.closing.getFormattedDate())")
                            .font(.white, Font.HafeflyRubik.medium, 22)
                    }
                    
                    HStack(spacing: 16){
                        Image("ic_people")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                        Text("\(barbershop.barbers.count) \(barbershop.barbers.count != 1 ? "barbers".localized : "barber".localized)")
                            .font(.white, Font.HafeflyRubik.medium, 26)
                    }
                }
            }
            .padding()
            .padding(.vertical, 8)
        }
        .background(LinearGradient(colors: [.hafeflyDarkBlue, .favoriteBlue], startPoint: .top, endPoint: .bottom).cornerRadius(22))
    }
}

struct BarbershopOverlay_Previews: PreviewProvider {
    static var previews: some View {
        BarbershopOverlay(Barbershop.barbershops[1])
    }
}
