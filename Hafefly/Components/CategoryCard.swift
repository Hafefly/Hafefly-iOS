//
//  CategoryCard.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import SwiftUI

struct CategoryCard: View {
    
    private let category: Category
    
    @State private var uiState: UiState<[Barbershop]>
    
    init(_ category: Category, uiState: UiState<[Barbershop]>) {
        self.category = category
        self.uiState = uiState
    }
    
    var body: some View {
        ZStack{
            VStack{
                VStack(alignment: .leading){
                    Text(category.rawValue)
                        .font(.white, Font.HafeflyRubik.semiBold, 22)
                        .multilineTextAlignment(.leading)
                    switch uiState {
                    case .idle:
                        EmptyView()
                    case .loading:
                        LoadingView()
                            .frame(width: 18, height: 18)
                    case .success(let barbershops):
                        if barbershops.isEmpty {
                            Text("empty")
                                .font(.white, Font.HafeflyRubik.regular, 18)
                        } else {
                            Text("\(barbershops.count) barbershop")
                                .font(.white, Font.HafeflyRubik.regular, 18)
                        }
                    case .failed:
                        Text("error")
                    }
                }
                .frame(width: 100, alignment: .leading)
                Spacer()
                ZStack{
                    Image(category.icon)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(category.color)
                        .frame(width: 24, height: 24)
                        .padding()
                        .background(Circle().fill(.white))
                }
            }
        }
        .frame(maxHeight: 170)
        .padding(.horizontal, 24)
        .padding(.vertical)
        .background(category.color)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.6), radius: 3, x: 4, y: 4)
    }
}

//struct CategoryCard_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryCard(Category.categories[1])
//    }
//}
