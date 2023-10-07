//
//  CategoryView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 9/3/2023.
//

import SwiftUI

struct CategoryView: View {
    
    private let category: Category
    private let barbershops: [Barbershop]
    
    init(_ category: Category, barbershops: [Barbershop]) {
        self.category = category
        self.barbershops = barbershops
    }
    
    var body: some View {
        ViewLayout {
            HeaderView(title: category.rawValue)
        } content: { edges in
            ZStack(alignment: .topLeading){
                ZStack(alignment: .top){
                    HStack{
                        Spacer()
                        ScrollView(showsIndicators: false){
                            LazyVStack {
                                ForEach(barbershops, id: \.id){
                                    BarbershopCard(barbershop: $0)
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding(.top, 55)
                    .background(Color.hafeflyBlue)
                    .cornerRadius(26)
                    
                    RoundedCorner(radius: 25, corners: [.topLeft, .topRight])
                        .frame(height: 52)
                        .foregroundColor(Color.hafeflyBlue)
                }.padding(8)
                
                Image(category.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28)
                    .padding(8)
                    .background(
                        Circle().fill(Color.white)
                    )
            }
            .padding(.horizontal, 8)
            .padding(.top, edges.top + 8)
            .padding(.bottom, edges.bottom)
            .frame(width: UIScreen.main.bounds.width)
        }
        .setupDefaultBackHandler()
    }
}

//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView(Category.categories[0])
//    }
//}
