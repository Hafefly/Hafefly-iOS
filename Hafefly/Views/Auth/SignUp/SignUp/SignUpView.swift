//
//  SignUpView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 6/3/2023.
//

import SwiftUI

struct SignUpView: View {
    
    let firstname: String
    let lastname: String
    let province: Province
    let phonenumber: String
    
    @StateObject private var model = Model()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rePassword: String = ""
    
    var body: some View {
        ViewLayout {
            //
        } content: { edges in
            VStack(alignment: .center){
                Spacer()
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                Spacer()
                VStack{
                    VStack{
                        TextField("email".localized, text: $email)
                            .textFieldStyle(HafeflyTextFieldStyle(uiState: model.emailUiState))
                        SecureField("password".localized, text: $password)
                            .textFieldStyle(HafeflyTextFieldStyle(uiState: model.passwordUiState))
                        SecureField("re_enter_password".localized, text: $rePassword)
                            .textFieldStyle(HafeflyTextFieldStyle(uiState: model.rePasswordUiState))
                    }
                    .onChange(of: password) { newValue in
                        model.validatePassword(newValue)
                        model.passwordsCheck(password: newValue, rePassword: rePassword)
                    }
                    .onChange(of: rePassword) { newValue in
                        model.passwordsCheck(password: password, rePassword: rePassword)
                    }
                }
                Spacer()
                HafeflyButton {
                    model.validateEnteries(firstname: firstname, lastname: lastname, province: province, phoneNumber: phonenumber, email: email, password: password, rePassword: rePassword)
                } label: {
                    Text("sign_up".localized)
                        .font(.white, Font.HafeflyRubik.semiBold, 18)
                }
                .padding(.bottom, 24)
            }
            .padding(24)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(firstname: "", lastname: "", province: .Algiers, phonenumber: "")
    }
}
