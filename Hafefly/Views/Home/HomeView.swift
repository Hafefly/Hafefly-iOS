//
//  HomeView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 6/3/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ViewLayout {
            HeaderView(title: "Hafefly")
        } content: { edges in
            VStack(alignment: .leading, spacing: 28){
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16){
                        ForEach(Category.categories, id: \.uuid) {
                            CategoryCard($0)
                        }.padding(.vertical)
                    }
                }
                
                VStack(alignment: .leading){
                    HStack{
                        Image("ic_ticket")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("vip_barbershops".localized)
                            .font(.white, .semiBold, 24)
                    }
                    ScrollView(showsIndicators: false){
                        VStack(spacing: 12){
                            ForEach(Barbershop.barbershops, id: \.id) { barbershop in
                                BarbershopCard(barbershop: barbershop, isFavorite: Category.categories[0].barbershops.contains{$0.id == barbershop.id})
                            }
                        }
                    }
                }
            }
            .padding(.top, edges.top + 16)
            .padding(.bottom, edges.bottom)
            .padding(.horizontal, 16)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(LinearGradient(colors: [.hafeflyBlue, .hafeflyDarkBlue], startPoint: .bottom, endPoint: .top))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
