//
//  ProfileView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var model = Model()
    
    @State private var isEditingProfile = false
    
    var body: some View {
        VStack(spacing: 16){
            profilePanel()
            switch model.historyUiState {
            case .idle: EmptyView()
            case .loading:
                LoadingView()
                    .frame(width: 24, height: 24)
            case .success(let ordersHistory):
                ScrollView(showsIndicators: false) {
                    VStack{
                        ForEach(ordersHistory, id: \.0.id) { order in
                            haircutHistoryPanel(orderHistory: order.0, barber: order.1, barbershop: order.2)
                        }
                    }
                }
            case .failed(let error):
                ZStack{
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Text(error)
                                .font(.white, Font.HafeflyRubik.medium, 18)
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding(16)
    }
    
    @ViewBuilder
    private func profilePanel() -> some View {
        ZStack(alignment: .leading){
            switch model.profileUiState {
            case .idle: EmptyView()
            case .loading: ZStack{HStack{Spacer();VStack{Spacer();}}}
            case .success(let user):
                HStack{
                    Spacer()
                    VStack{
                        Button {
                            self.isEditingProfile.toggle()
                        } label: {
                            Image("ic_edit")
                                .padding(4)
                                .background(Circle().foregroundColor(Color.black.opacity(0.7)))
                        }
                        Spacer()
                    }
                }
                HStack(spacing: 16){
                    Image(user.profileImage ?? "avatar")
                        .resizable()
                        .frame(width: 90, height: 90)
                        .cornerRadius(.infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: .infinity)
                                .stroke(Color.white, lineWidth: 4)
                        )
                    if !isEditingProfile {
                        VStack(alignment: .leading, spacing: 12){
                            Text("\(user.lastname) \(user.firstname)")
                                .font(.white, Font.HafeflyRubik.semiBold, 22)
                            
                            if let phone = user.phone {
                                HStack{
                                    Image("ic_phone")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                    Text(phone)
                                        .font(.white, Font.HafeflyRubik.regular, 18)
                                }
                            }
                            
                            if let instagram = user.instagram {
                                HStack{
                                    Image("ic_instagram")
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                    Text(instagram.localized)
                                        .font(.white, Font.HafeflyRubik.regular, 18)
                                }
                            }
                            
                            HStack{
                                Image("ic_checkmark")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                Text("\(String(user.haircutsDone)) \(user.haircutsDone.whichString(single: "haircut", plural: "haircuts"))")
                                    .font(.white, Font.HafeflyRubik.regular, 18)
                            }
                            HafeflyButton(action: model.loggout) {
                                Text("sign out")
                                    .font(.white, .medium, 18)
                                    .padding(.vertical, 4)
                            }
                            
                        }
                    } else {
                        #warning("implement editing profile")
                        Spacer()
                    }
                }
            case .failed(let error):
                ZStack{
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            VStack{
                                Text(error)
                                    .font(.white, .medium, 18)
                                Button(action: model.loggout) {
                                    Text("loggout")
                                        .font(.white, .medium, 18)
                                }
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding()
        .frame(maxHeight: 160)
        .background(Color.favoriteBlue)
        .cornerRadius(16)
    }
    
    @ViewBuilder
    private func haircutHistoryPanel(orderHistory: Order, barber: Barber, barbershop: Barbershop) -> some View {
        ZStack(alignment: .trailing){
            Image(barbershop.name)
                .resizable()
                .scaledToFit()
                .frame(height: 140)
                .overlay(LinearGradient(colors: [.favoriteBlue, .clear], startPoint: .leading, endPoint: .trailing))
            LinearGradient(colors: [.black.opacity(0.3), .clear], startPoint: .bottom, endPoint: .top)
            HStack{
                Image(barber.profileImage ?? "BarberAvatar")
                    .resizable()
                    .frame(width: 63, height: 103)
                    .background(Color.white)
                    .cornerRadius(16)
                VStack(alignment: .leading){
                    Text(barber.firstname)
                        .font(.white, Font.HafeflyRubik.semiBold, 24)
//                    Text(haircutHistory.barbershop.name)
//                        .font(.white, Font.HafeflyRubik.regular, 20)
                    Text(orderHistory.confirmedInterval?.timeString ?? "time missed")
                        .font(.white, Font.HafeflyRubik.regular, 20)
                    Spacer()
                    HStack{
                        Image("ic_gps")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text(barbershop.town)
                            .font(.white, Font.HafeflyRubik.regular, 20)
                    }
                }
                .padding(.vertical, 6)
                Spacer()
                VStack(alignment: .trailing){
                    Text("\(orderHistory.totalPrice.toString) DA")
                        .font(.white, Font.HafeflyRubik.regular, 20)
                        .padding(4)
                        .padding(.horizontal, 8)
                        .background(Color.favoriteBlue)
                        .cornerRadius(4)
                    Spacer()
                    Text("double_tap_to_review".localized)
                        .font(.white, Font.HafeflyRubik.regular, 14)
                }
            }
            .padding()
        }
        .frame(height: 140)
        .background(Color.favoriteBlue)
        .cornerRadius(16)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .padding()
    }
}
