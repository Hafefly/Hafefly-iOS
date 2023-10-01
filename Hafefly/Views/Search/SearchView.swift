//
//  SearchView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var model = Model()
    
    var body: some View {
        VStack{
            TextField("search".localized, text: $model.searchText)
                .foregroundColor(.hafeflyLightBlue)
                .padding()
                .background(Color.favoriteBlue)
                .cornerRadius(.infinity)
                .shadow(color: .favoriteBlue, radius: 10)
            
            switch model.searchUiState {
            case .idle:
                EmptyView()
            case .loading:
                #warning("implement loading view")
                EmptyView()
            case .success(let barbershops):
                ScrollView(showsIndicators: false) {
                    VStack{
                        ForEach(barbershops, id: \.id){
                            BarbershopCard(barbershop: $0)
                        }
                    }
                }
            case .failed(let string):
                #warning("implement fail view")
                EmptyView()
            }
        }
        .onReceive(model.$searchText, perform: model.search)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .background(LinearGradient(colors: [.hafeflyDarkBlue, .favoriteBlue], startPoint: .top, endPoint: .bottom))
    }
}
