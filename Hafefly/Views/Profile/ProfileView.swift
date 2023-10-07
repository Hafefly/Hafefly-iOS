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
        VStack{
            profilePanel()
            switch model.historyUiState {
            case .idle: EmptyView()
            case .loading: ZStack{HStack{Spacer();VStack{Spacer();}}}
            case .success(let haircutsHistory):
                ScrollView(showsIndicators: false) {
                    VStack{
                        ForEach(haircutsHistory) {
                            haircutHistoryPanel(haircutHistory: $0)
                        }
                    }
                }
            case .failed(let error):
                ZStack{
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Text(error ?? "something_went_wrong".localized)
                                .font(.white, Font.HafeflyRubik.medium, 18)
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding(.bottom, 8)
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
                VStack{
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
                            VStack(alignment: .leading){
                                Text("\(user.lastname) \(user.firstname)")
                                    .font(.white, Font.HafeflyRubik.semiBold, 22)
                                HStack{
                                    Image("ic_phone")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                    Text(user.phone ?? "none".localized)
                                        .font(.white, Font.HafeflyRubik.regular, 18)
                                }
                                HStack{
                                    Image("ic_instagram")
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                    Text(user.instagram ?? "none".localized)
                                        .font(.white, Font.HafeflyRubik.regular, 18)
                                }
                                HStack{
                                    Image("ic_checkmark")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                    Text("\(String(user.haircutsDone)) \(user.haircutsDone.whichString(single: "haircut_done", plural: "haircuts_done"))")
                                        .font(.white, Font.HafeflyRubik.regular, 18)
                                    Spacer()
                                    HafeflyButton(action: model.loggout) {
                                        Text("sign out")
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        } else {
                            Spacer()
                        }
                    }
                    if self.isEditingProfile {
                        #warning("implement editing profile")
                    }
                }
            case .failed(let error):
                ZStack{
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Button(action: model.loggout) {
                                Text("loggout")
                                    .font(.white, .medium, 18)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding()
        .frame(maxHeight: 150)
        .background(Color.favoriteBlue)
        .cornerRadius(16)
    }
    
    @ViewBuilder
    private func haircutHistoryPanel(haircutHistory: HaircutHistory) -> some View {
        ZStack(alignment: .trailing){
            Image(haircutHistory.barbershop.name)
                .resizable()
                .scaledToFit()
                .frame(height: 140)
                .overlay(LinearGradient(colors: [.favoriteBlue, .clear], startPoint: .leading, endPoint: .trailing))
            LinearGradient(colors: [.black.opacity(0.3), .clear], startPoint: .bottom, endPoint: .top)
            HStack{
                Image(haircutHistory.barber.profileImage ?? "BarberAvatar")
                    .resizable()
                    .frame(width: 63, height: 103)
                    .background(Color.white)
                    .cornerRadius(16)
                VStack(alignment: .leading){
                    Text(haircutHistory.barber.name)
                        .font(.white, Font.HafeflyRubik.semiBold, 24)
//                    Text(haircutHistory.barbershop.name)
//                        .font(.white, Font.HafeflyRubik.regular, 20)
                    Text("\(haircutHistory.time.openingDate.getFormattedDate()) - \(haircutHistory.time.openingDate.getFormattedDate())")
                        .font(.white, Font.HafeflyRubik.regular, 20)
                    Spacer()
                    HStack{
                        Image("ic_gps")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text(haircutHistory.barbershop.town)
                            .font(.white, Font.HafeflyRubik.regular, 20)
                    }
                }
                .padding(.vertical, 6)
                Spacer()
                VStack(alignment: .trailing){
                    Text("\(haircutHistory.price.toString) DA")
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
