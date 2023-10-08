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
    let pricing: Pricing
    
    init(_ barber: Barber, pricing: Pricing) {
        self.barber = barber
        self.pricing = pricing
    }
    
    var body: some View {
        VStack{
            HStack(spacing: 16){
                Image(barber.profileImage ?? "BarberAvatar")
                    .scaleEffect(1.3)
                    .background(Color.white)
                    .cornerRadius(14)
                
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
            .padding(.top, 65)
            .padding(.bottom)
            .padding(.horizontal)
            .background(Color.favoriteBlue)
            .cornerRadius(18, corners: [.bottomRight, .bottomLeft])
            .ignoresSafeArea()
            VStack{
                workingHoursPanel(open: barber.workingHours.openingDate.getFormattedHour(), close: barber.workingHours.closingDate.getFormattedHour())
                    .shadow(radius: 4)
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
                    
                Spacer()
                
                HafeflyButton(foregroundColor: .orange) {
                    pushScreen(BookView(pricing))
                } label: {
                    Text("book".localized)
                        .font(.white, Font.HafeflyRubik.bold, 24)
                }
            }
            .padding()
        }
        .background(LinearGradient(colors: [.hafeflyBlue, .hafeflyDarkBlue], startPoint: .bottom, endPoint: .top).ignoresSafeArea())
        .onAppear {
            model.getReviews(for: barber.id)
        }
    }
    
    @ViewBuilder
    private func workingHoursPanel(open: String, close: String) -> some View {
        HStack{
            VStack(alignment: .leading){
                Text("Working hours")
                    .font(.white, Font.HafeflyRubik.semiBold, 22)
                Spacer()
                Text("\(open) - \(close)")
                    .font(.white.opacity(0.8), Font.HafeflyRubik.regular, 18)
            }
            Spacer()
            Image("ilu_mower")
        }
        .fixedSize(horizontal: false, vertical: true)
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

struct BarberView_Previews: PreviewProvider {
    static var previews: some View {
        let barbershop = Barbershop(id: "", name: "fasta", imageUrl: nil, town: "", rating: 0.0, workingHours: WorkingHours(opening: "", closing: ""), pricing: Pricing(fade: 0, beard: 0, hairdryer: 0, razor: 0, scissors: 0, straightener: 0, atHome: 0), coordinate: Coordinate(latitude: 0.0, longitude: 0.0), vip: true, barbers: [Barber(barbershopUID: "", barbershopName: "", firstname: "Kamel", lastname: "Mat", bio: "bio", age: 20, experience: 5, haircutsDone: 5, instagram: "", isAvailableToHome: true, phoneNumber: "", province: "", rating: 4.4, verified: true, workingHours: WorkingHours(opening: "08:00Z", closing: "18:00Z"))])
        if let barber = barbershop.barbers?[0], let pricing = barbershop.pricing {
            BarberView(barber, pricing: pricing)
        }
    }
}
