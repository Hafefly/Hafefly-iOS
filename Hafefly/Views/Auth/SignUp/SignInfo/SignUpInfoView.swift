//
//  SignUpInfoView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 7/3/2023.
//

import SwiftUI
import HFNavigation

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
                VStack{
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                }
                Spacer()
                VStack{
                    VStack{
                        HStack {
                            TextField("firstname".localized, text: $firstname)
                                .placeholder(when: firstname.isEmpty) {
                                        Text("firstname")
                                            .foregroundColor(.white.opacity(0.7))
                                }
                                .textFieldStyle(getHFTextFieldStye(model.firstnameUiState))
                                .onChange(of: lastname) { newValue in
                                    model.setFirstnameUiState(model.validateName(newValue))
                                }
                            TextField("lastname".localized, text: $lastname)
                                .placeholder(when: lastname.isEmpty) {
                                        Text("lastname")
                                            .foregroundColor(.white.opacity(0.7))
                                }
                                .textFieldStyle(getHFTextFieldStye(model.lastnameUiState))
                                .onChange(of: lastname) { newValue in
                                    model.setLastnameUiState(model.validateName(newValue))
                                }
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
                                .placeholder(when: phonenumber.isEmpty) {
                                        Text("phone number")
                                            .foregroundColor(.white.opacity(0.7))
                                }
                                .textFieldStyle(getHFTextFieldStye(model.phoneNumberUiState))
                                .onChange(of: phonenumber) { newValue in
                                    model.validatePhoneFormat(newValue)
                                }
                            
                            HafeflyButton(disabled: model.otpButtonDisabled) {
                                model.sendOtp(phonenumber: phonenumber)
                            } label: {
                                Text(model.otpButtonText)
                                    .font(.white, Font.HafeflyRubik.regular, 16)
                            }
                            .frame(width: 100, height: 56)
                        }
                    }
                }
                Spacer()
                HafeflyButton {
                    model.checkInfo(firstname: firstname, lastname: lastname, province: province, phoneNumber: phonenumber, otpCode: otpCode)
                } label: {
                    Text("continue".localized)
                        .font(.white, Font.HafeflyRubik.semiBold, 18)
                }.padding(.bottom, 24)
            }
            .padding(16)
        }
    }
}

struct SignUpInfo_Previews: PreviewProvider {
    static var previews: some View {
        SignUpInfoView()
    }
}
