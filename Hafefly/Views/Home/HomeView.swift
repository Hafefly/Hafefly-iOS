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
                    ForEach(Category.allCases) { category in
                        Button {
                            switch model.getUiState(category) {
                            case .success(let barbershops):
                                model.openCategory(category, barbershops: barbershops)
                            default:
                                break
                            }
                        } label: {
                            CategoryCard(category, uiState: model.favoritesBarbershopsUiState)
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
                            switch model.favoritesBarbershopsUiState {
                            case .success(let favorite):
                                LazyVStack(spacing: 16){
                                    ForEach(barbershops, id: \.id) { barbershop in
                                        BarbershopCard(barbershop: barbershop, isFavorite: favorite.contains{$0.id == barbershop.id})
                                    }
                                }
                            default:
                                EmptyView()
                            }
                        case .idle, .loading:
                            LoadingView()
                                .frame(width: 24, height: 24)
                        case .failed(let error):
                            FailView(errorMess: error)
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
