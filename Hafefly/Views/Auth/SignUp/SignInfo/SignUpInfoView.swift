//
//  SignUpInfoView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 7/3/2023.
//

import SwiftUI

struct SignUpInfoView: View {
    
    @StateObject private var model = Model()
    
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var phonenumber: String = ""
    @State private var otpCode: String = ""
    
    @State private var province: Province = .Algiers
    
    var body: some View {
        ViewLayout {
            EmptyView()
        } content: { edges in
            VStack(alignment: .center){
                Spacer()
                    .frame()
                VStack{
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                }
                Spacer()
                    .frame()
                VStack{
                    VStack{
                        HStack {
                            TextField("firstname".localized, text: $firstname)
                            TextField("lastname".localized, text: $lastname)
                        }
                        Picker("province".localized, selection: $province) {
                            ForEach(Province.allCases, id: \.hashValue) {
                                Text($0.rawValue)
                                    .font(.hafeflyLightBlue, Font.HafeflyRubik.medium, 18)
                                    .padding()
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 56)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.hafeflyLightBlue, lineWidth: 4)
                        )
                        .cornerRadius(8)
                        .shadow(color: .hafeflyLightBlue, radius: 10)
                        HStack{
                            TextField("phonenumber".localized, text: $phonenumber)
                            HafeflyButton(disabled: model.otpButtonDisabled) {
                                model.sendOtp(phonenumber: phonenumber)
                            } label: {
                                Text(model.otpButtonText)
                                    .font(.white, Font.HafeflyRubik.regular, 16)
                            }.frame(width: 100, height: 56)
                        }
                        
                    }.textFieldStyle(HafeflyTextFieldStyle())
                    HStack{
                        Text("forgot_password".localized)
                            .font(.white, Font.HafeflyRubik.medium, 18)
                        Spacer()
                    }.padding(.horizontal, 8)
                }
                Spacer()
                    .frame()
                HafeflyButton {
                    continueSignUp(firstname: firstname, lastname: lastname, province: province, phonenumber: phonenumber)
                } label: {
                    Text("continue".localized)
                        .font(.white, Font.HafeflyRubik.semiBold, 18)
                }.padding(.bottom, 24)
            }
            .padding()
        }
    }
    
    private func continueSignUp(firstname: String, lastname: String, province: Province, phonenumber: String){
        model.verifyOtp(for: phonenumber, code: otpCode) { success in
            if success {
                NavigationCoordinator.pushScreen(.signup(firstname, lastname, province, phonenumber))
            }
        }
    }
}

struct SignUpInfo_Previews: PreviewProvider {
    static var previews: some View {
        SignUpInfoView()
    }
}
