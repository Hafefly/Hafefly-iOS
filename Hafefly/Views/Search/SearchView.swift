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
        VStack(spacing: 24){
            TextField("search".localized, text: $model.searchText)
                .placeholder(when: model.searchText.isEmpty) {
                        Text("search")
                            .foregroundColor(.white.opacity(0.7))
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.favoriteBlue)
                .cornerRadius(10)
            
            
            switch model.searchUiState {
            case .idle:
                Spacer()
            case .loading:
                LoadingView()
                    .frame(width: 24, height: 24)
            case .success(let barbershops):
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12){
                        ForEach(barbershops, id: \.id){
                            BarbershopCard(barbershop: $0)
                        }
                    }
                    Spacer()
                }
            case .failed(let error):
                FailView(errorMess: error)
            }
            Spacer()
        }
        .padding(16)
        .onReceive(model.$searchText, perform: model.search)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .background(LinearGradient(colors: [.hafeflyDarkBlue, .favoriteBlue], startPoint: .top, endPoint: .bottom))
    }
}
