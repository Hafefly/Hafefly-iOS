//
//  BarberView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 12/3/2023.
//

import SwiftUI

struct BarberView: View {
    
    let barber: Barber
    let pricing: Pricing
    
    init(_ barber: Barber, pricing: Pricing) {
        self.barber = barber
        self.pricing = pricing
    }
    var body: some View {
        VStack{
            HStack(spacing: 16){
                Image(barber.profileImage ?? "BarberAvatar")
                    .background(Color.white)
                    .cornerRadius(24)
                VStack(alignment: .leading){
                    Text(barber.name)
                        .font(.white, Font.HafeflyRubik.semiBold, 22)
                    HStack{
                        Image("ic_clock")
                        Text("\(barber.experience.toString) \(barber.experience.whichString(single: "year", plural: "years")) exp")
                            .font(.white, Font.HafeflyRubik.medium, 18)
                    }
                    Text(barber.bio)
                        .font(.white, Font.HafeflyRubik.regular, 18)
                    HStack{
                        Spacer()
                        HStack{
                            Image("ic_star")
                            Text("\(barber.rating.rating())")
                                .font(.white, Font.HafeflyRubik.regular, 22)
                        }
                    }
                }
            }
            .padding()
            .padding(.top, 38)
            .padding(.horizontal)
            .background(Color.favoriteBlue.ignoresSafeArea())
            .cornerRadius(18, corners: [.bottomRight, .bottomLeft])
            VStack{
                workingHoursPanel(open: barber.workingHours.opening.getFormattedDate(), close: barber.workingHours.opening.getFormattedDate())
                    .shadow(radius: 4)
                reviewCard(reviews: barber.reviews)
                Spacer()
                
                HafeflyButton(foregroundColor: .orange) {
                    NavigationCoordinator.pushScreen(.book(pricing))
                } label: {
                    Text("book".localized)
                        .font(.white, Font.HafeflyRubik.bold, 24)
                }
            }
            .padding()
        }
        .background(LinearGradient(colors: [.hafeflyBlue, .hafeflyDarkBlue], startPoint: .bottom, endPoint: .top).ignoresSafeArea())
        .padding(.bottom, 16)
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private func workingHoursPanel(open: String, close: String) -> some View {
        HStack{
            VStack(alignment: .leading){
                Text("Working hours")
                    .font(.white, Font.HafeflyRubik.semiBold, 22)
                Text("\(open) - \(close)")
                    .font(.white.opacity(0.8), Font.HafeflyRubik.regular, 18)
            }
            Spacer()
            Image("ilu_mower")
        }
        .padding(12)
        .background(Color.favoriteBlue)
        .cornerRadius(18)
    }
    
    @ViewBuilder
    private func reviewCard(reviews: [Review]) -> some View {
        VStack{
            HStack{
                HStack{
                    Image("ic_thumbup")
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("reviews".localized)
                        .font(.white, Font.HafeflyRubik.bold, 26)
                }
                Spacer()
                Button {
                    #warning("implement show all screen")
                } label: {
                    Text("show_all".localized)
                        .font(.white, Font.HafeflyRubik.regular, 18)
                }

            }
            if reviews.isEmpty {
                Text("this_barber_has_no_reviews".localized)
                    .font(.white, Font.HafeflyRubik.regular, 20)
                    .padding(.vertical)
            } else {
                ScrollView(showsIndicators: false) {
                    VStack{
                        ForEach(reviews) {
                            reviewPanel(review: $0)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.favoriteBlue)
        .cornerRadius(18)
    }
    
    @ViewBuilder
    private func reviewPanel(review: Review) -> some View {
        HStack{
            Image("ic_profile")
                .resizable()
                .frame(width: 24, height: 24)
            VStack(alignment: .leading){
                Text(review.username)
                    .font(.white, Font.HafeflyRubik.medium, 22)
                Text(review.message)
                    .font(.white, Font.HafeflyRubik.regular, 18)
            }
            Spacer()
            if let rating = review.rating?.rating() {
                HStack{
                    Image("ic_star")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text(rating)
                        .font(.white, Font.HafeflyRubik.semiBold, 22)
                }
            }
        }
    }
}

struct BarberView_Previews: PreviewProvider {
    static var previews: some View {
        let barbershop = Barbershop.barbershops[0]
        BarberView(barbershop.barbers[0], pricing: barbershop.pricing)
    }
}
