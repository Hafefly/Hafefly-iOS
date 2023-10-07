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
                    VStack{
                        if let barbers = barbershop.barbers {
                            ScrollView {
                                ForEach(barbers) {
                                    Spacer()
                                        .frame(height: 28)
                                    BarberCard($0)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
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
    let barber: Barber
    
    init(_ barber: Barber) {
        self.barber = barber
    }
    
    var body: some View {
        HStack(spacing: 18){
            Image(barber.profileImage ?? "BarberAvatar")
                .resizable()
                .frame(width: 92, height: 158)
                .background(Color.white)
                .cornerRadius(14)
                .offset(y: -24)
            
            HStack(alignment: .top){
                VStack(alignment: .leading, spacing: 24){
                    VStack(alignment: .leading){
                        Text(barber.firstname + barber.lastname)
                            .font(.white, .medium, 20)
                        HStack{
                            Image("ic_clock")
                                .frame(width: 18, height: 18)
                            Text("\(barber.experience) years exp")
                                .font(.white, Font.HafeflyRubik.regular, 14)
                        }
                        .opacity(0.7)
                    }
                    VStack(alignment: .leading, spacing: 8){
                        Text("Working hours")
                            .font(.white, .medium, 16)
                        Text(
                            barber.workingHours.openingDate.getFormattedHour()
                            + "->"
                            + barber.workingHours.closingDate.getFormattedHour()
                        )
                        .font(.white, Font.HafeflyRubik.medium, 14)
                    }
                }
                Spacer()
                HStack{
                    Image("ic_star")
                        .frame(width: 24, height: 24)
                    Text("\(barber.rating.rating())")
                        .font(.white, Font.HafeflyRubik.regular, 22)
                }
            }
        }
        .frame(maxHeight: 120)
        .padding()
        .background(Color.favoriteBlue.cornerRadius(20).shadow(color: .black.opacity(0.32), radius: 5, x: 0, y: 4))
    }
}
