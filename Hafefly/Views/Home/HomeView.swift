//
//  HomeView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 6/3/2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var model = Model()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 28){
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16){
                    ForEach(Category.categories, id: \.uuid) { category in
                        Button {
                            model.openCategory(category)
                        } label: {
                            CategoryCard(category)
                        }
                    }
                    .padding(.vertical)
                }
            }
            
            VStack(alignment: .leading){
                HStack{
                    Image("ic_ticket")
                        .resizable()
                        .frame(width: 26, height: 22)
                    Text("vip_barbershops".localized)
                        .font(.white, Font.HafeflyRubik.semiBold, 24)
                }
                ScrollView(showsIndicators: false){
                    ZStack{
                        switch model.barbershopsUiState {
                        case .success(let barbershops):
                            LazyVStack(spacing: 16){
                                ForEach(barbershops, id: \.id) { barbershop in
                                    BarbershopCard(barbershop: barbershop, isFavorite: Category.categories[0].barbershops.contains{$0.id == barbershop.id})
                                }
                            }
                        case .idle, .loading:
                            Spacer()
                            ProgressView()
                                .frame(width: 40, height: 40)
                            Spacer()
                        case .failed(let error):
                            HStack{
                                Spacer()
                                VStack{
                                    Spacer()
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
