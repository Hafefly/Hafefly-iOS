//
//  ProfileView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var model = Model()
    
    var body: some View {
        VStack{
            ZStack(alignment: .leading){
                switch model.uiState {
                case .idle: EmptyView()
                case .loading: ZStack{HStack{Spacer();VStack{Spacer();}}}
                case .success(let barber):
                    HStack{
                        Spacer()
                        VStack{
                            Button {
                                
                            } label: {
                                Image("ic_edit")
                                    .padding(4)
                                    .background(Circle().foregroundColor(Color.black.opacity(0.7)))
                            }
                            Spacer()
                        }
                    }
                    HStack(spacing: 16){
                        VStack{
                            Image(barber.profileImage ?? "avatar")
                                .resizable()
                                .frame(width: 90, height: 90)
                                .cornerRadius(.infinity)
                                .overlay(
                                    RoundedRectangle(cornerRadius: .infinity)
                                        .stroke(Color.white, lineWidth: 4)
                                )
                            Text(barber.name)
                                .font(.white, Font.HafeflyRubik.semiBold, 22)
                        }
                        
                        VStack(alignment: .leading){
                            HStack{
                                Image("ic_phone")
                                Text(barber.phone)
                                    .font(.white, Font.HafeflyRubik.regular, 20)
                            }
                            HStack{
                                Image("ic_instagram")
                                Text(barber.instagram)
                                    .font(.white, Font.HafeflyRubik.regular, 20)
                            }
                            HStack{
                                Image("ic_checkmark")
                                Text("\(String(barber.haircutsDone)) \(barber.haircutsDone.whichString(single: "haircut_done", plural: "haircuts_done"))")
                                    .font(.white, Font.HafeflyRubik.regular, 20)
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
            .padding()
            .frame(maxHeight: 150)
            .background(Color.favoriteBlue)
            .cornerRadius(16)
            Spacer()
            HafeflyButton(foregroundColor: .red){
                #warning("add signout")
            } label: {
                Text("sign_out".localized)
                    .font(.white, Font.HafeflyRubik.regular, 18)
            }
            .padding(.bottom, 8)

        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .padding()
    }
}
