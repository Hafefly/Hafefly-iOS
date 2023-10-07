//
//  BarbershopView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 11/3/2023.
//

import SwiftUI
import CardStack

struct BarbershopView: View {
    
    let barbershop: Barbershop
    
    init(_ barbershop: Barbershop) {
        self.barbershop = barbershop
    }
    
    var body: some View {
        ViewLayout {
            HeaderView(title: barbershop.name)
        } content: { edges in
            ZStack(alignment: .top){
                VStack(alignment: .center){
                    ZStack(alignment: .bottom){
                        Image(barbershop.name)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width)
                            .overlay(LinearGradient(colors: [Color(red: 27/255, green: 38/255, blue: 96/255), .clear], startPoint: .bottom, endPoint: .top))
                        HStack{
                            HStack{
                                buttonStyle(color: .blue, icon: "ic_gps") {
                                    #warning("take to map")
                                }
                                VStack(alignment: .leading, spacing: 4){
                                    Text(barbershop.town)
                                        .font(.white, Font.HafeflyRubik.medium, 28)
                                    HStack(spacing: 4){
                                        Image("ic_star")
                                            .resizable()
                                            .frame(width: 18, height: 18)
                                        Text(barbershop.rating.rating())
                                            .font(.white, Font.HafeflyRubik.medium, 18)
                                    }
                                }
                            }
                            Spacer()
                            buttonStyle(color: .red, icon: "ic_heart") {
                                #warning("add to favorite")
                            }
                        }.padding()
                    }
                    if let barbers = barbershop.barbers {
                        CardStack(direction: LeftRight.direction, data: barbers) { _, _ in } content: { barber, _, _ in
                            VStack{
                                Spacer()
                                HStack{
                                    Spacer()
                                    BarberCard(barber) {
                                        if let pricing = barbershop.pricing {
                                            pushScreen(BarberView(barber, pricing: pricing))
                                        }
                                    }
                                    Spacer()
                                }
                                Spacer()
                            }
                        }.environment(\.cardStackConfiguration, CardStackConfiguration(
                            maxVisibleCards: 3,
                            swipeThreshold: 0.1,
                            cardOffset: 40,
                            cardScale: 0.2,
                            animation: .linear
                        ))
                        Spacer()
                    }
                }
            }
            .padding(.top, edges.top)
            .setupDefaultBackHandler()
        }
    }
    
    @ViewBuilder
    private func buttonStyle(color: Color, icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(icon)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.white)
                .frame(width: 34, height: 34)
                .padding(8)
                .background(LinearGradient(colors: [color, color.lighter()], startPoint: .bottomTrailing, endPoint: .topLeading).cornerRadius(.infinity))
        }
    }
}

//struct BarbershopView_Previews: PreviewProvider {
//    static var previews: some View {
//        BarbershopView(Barbershop.barbershops[0])
//    }
//}

struct BarberCard: View {
    
    private let barber: Barber
    private let action: () -> Void
    
    init(_ barber: Barber, action: @escaping () -> Void) {
        self.barber = barber
        self.action = action
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 24){
            HStack(spacing: 16){
                Image(barber.profileImage ?? "BarberAvatar")
                    .resizable()
                    .frame(width: 92, height: 158)
                    .background(Color.white)
                    .cornerRadius(24)
                VStack(alignment: .leading){
                    Text(barber.firstname)
                        .font(.white, Font.HafeflyRubik.regular, 22)
                    HStack{
                        Image("ic_clock")
                            .resizable()
                            .frame(width: 18, height: 18)

                        Text("\(barber.experience.toString) \(barber.experience.whichString(single: "year", plural: "years")) exp")
                            .font(.white, Font.HafeflyRubik.regular, 18)
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        HStack{
                            Image("ic_star")
                            Text(barber.rating.rating())
                                .font(.white, Font.HafeflyRubik.regular, 22)
                        }
                    }
                }
                .padding(.vertical)
            }
            VStack(alignment: .leading, spacing: 16){
                VStack(alignment: .leading){
                    Text("working_hours".localized)
                        .font(.white, Font.HafeflyRubik.medium, 24)
                    Text("\(barber.workingHours.openingDate.getFormattedDate()) - \(barber.workingHours.openingDate.getFormattedDate())")
                        .font(.white.opacity(0.8), Font.HafeflyRubik.regular, 18)
                }
                Text(barber.bio)
                    .font(.white, Font.HafeflyRubik.regular, 18)
            }
            
            Button(action: action) {
                HStack{
                    Spacer()
                    Text("book".localized)
                        .font(.white, Font.HafeflyRubik.medium, 20)
                    Spacer()
                }
                .padding(8)
                .background(Color.orange)
                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                .cornerRadius(4, corners: [.topLeft, .topRight])
            }
        }
        .fixedSize(horizontal: true, vertical: true)
        .padding()
        .background(Color.favoriteBlue)
        .cornerRadius(24)
    }
}
