//
//  SearchView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var model = Model()
    
    @State private var searchText: String = ""
    
    var body: some View {
        VStack{
            TextField("search".localized, text: $searchText)
                .foregroundColor(.hafeflyLightBlue)
                .padding()
                .background(Color.favoriteBlue)
                .cornerRadius(.infinity)
                .shadow(color: .favoriteBlue, radius: 10)
            ScrollView(showsIndicators: false) {
                VStack{
                    ForEach(model.searchedBarbershops, id: \.id){
                        BarbershopCard(barbershop: $0)
                    }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .background(LinearGradient(colors: [.hafeflyDarkBlue, .favoriteBlue], startPoint: .top, endPoint: .bottom))
    }
}
