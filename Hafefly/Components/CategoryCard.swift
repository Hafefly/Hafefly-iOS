//
//  CategoryCard.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import SwiftUI

struct CategoryCard: View {
    
    let category: Category
    
    init(_ category: Category) {
        self.category = category
    }
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text(category.name)
                    .font(.white, .semiBold, 22)
                if category.barbershops.isEmpty {
                    Text("empty")
                        .font(.white, .regular, 18)
                } else {
                    Text("\(category.itemsCount) barbershop")
                        .font(.white, .regular, 18)
                }
            }
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
        .frame(width: 100)
        .frame(maxHeight: 170)
        .padding(.horizontal, 24)
        .padding(.vertical)
        .background(category.color)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.6), radius: 3, x: 4, y: 4)
    }
}

struct CategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCard(Category(icon: "ic_heart", name: "Favorite", color: .red, barbershops: []))
    }
}
