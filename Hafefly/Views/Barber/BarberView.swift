//
//  BarberView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 12/3/2023.
//

import SwiftUI
import HFNavigation

struct BarberView: View {
    
    @StateObject private var model = Model()
    
    let barber: Barber
    let barbershop: Barbershop
    
    init(_ barber: Barber, barbershop: Barbershop) {
        self.barber = barber
        self.barbershop = barbershop
    }
    
    var body: some View {
        ViewLayout {
            barberHeader(barber: barber)
        } content: { edges in
            VStack{
                workingHoursPanel(open: barber.workingHours.openingDate.getFormattedHour(), close: barber.workingHours.closingDate.getFormattedHour())
                    .shadow(radius: 4)
                Spacer()
                switch model.reviewsUiState {
                case .idle:
                    EmptyView()
                case .loading:
                    LoadingView()
                        .frame(width: 24, height: 24)
                case .success(let reviews):
                    reviewCard(reviews: reviews)
                case .failed(let error):
                    FailView(errorMess: error)
                }
                
                HafeflyButton(radius: 18, foregroundColor: .orange) {
                    pushScreen(BookView(barbershop, barber: barber))
                } label: {
                    Text("book".localized)
                        .font(.white, Font.HafeflyRubik.bold, 24)
                }
            }
            .padding(16)
        }
        .onAppear {
            model.getReviews(for: barber.id)
        }
    }
    
    @ViewBuilder
    private func barberHeader(barber: Barber) -> some View {
        VStack(alignment: .leading){
            HStack(spacing: 18){
                Image(barber.profileImage ?? "BarberAvatar")
                    .scaleEffect(1.5)
                    .background(Color.white)
                    .cornerRadius(14)
                
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text(barber.firstname + " " + barber.lastname)
                            .font(.white, Font.HafeflyRubik.semiBold, 22)
                        HStack{
                            Image("ic_clock")
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text("\(barber.experience.toString) \(barber.experience.whichString(single: "year", plural: "years")) exp")
                                .font(.white, Font.HafeflyRubik.medium, 18)
                        }
                        Text(barber.bio)
                            .font(.white, Font.HafeflyRubik.regular, 18)
                    }
                }
            }
            HStack{
                Spacer()
                HStack{
                    Image("ic_star")
                    Text("\(barber.rating.rating())")
                        .font(.white, Font.HafeflyRubik.regular, 22)
                }
            }
        }
        .padding(.vertical)
        .padding(.horizontal, 36)
        .background(Color.favoriteBlue)
        .cornerRadius(18, corners: [.bottomRight, .bottomLeft])
    }
    
    @ViewBuilder
    private func workingHoursPanel(open: String, close: String) -> some View {
        HStack{
            VStack(alignment: .leading, spacing: 16){
                Text("Working hours")
                    .font(.white, Font.HafeflyRubik.semiBold, 22)
                Text("\(open) - \(close)")
                    .font(.white.opacity(0.8), Font.HafeflyRubik.regular, 18)
            }
            Spacer()
            Image("ilu_mower")
        }
        .padding()
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
                VStack{
                    ForEach(reviews) {
                        reviewPanel(review: $0)
                    }
                    Spacer()
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
                .frame(width: 38, height: 38)
            VStack(alignment: .leading){
                Text(review.user?.firstname ?? "anonymos")
                    .font(.white, Font.HafeflyRubik.medium, 24)
                Text(review.message ?? "hidden")
                    .font(.white.opacity(0.8), Font.HafeflyRubik.regular, 16)
            }
            Spacer()
            
            HStack{
                Image("ic_star")
                    .resizable()
                    .frame(width: 24, height: 24)
                Text(review.rating.rating())
                    .font(.white, Font.HafeflyRubik.semiBold, 22)
            }
        }
    }
}
