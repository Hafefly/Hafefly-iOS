//
//  LoginView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 6/3/2023.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var model = Model()
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ViewLayout {
            EmptyView()
        } content: { edges in
            VStack(alignment: .center){
                Spacer()
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                Spacer()
                VStack{
                    VStack{
                        TextField("email".localized, text: $email)
                            .placeholder(when: email.isEmpty) {
                                    Text("search")
                                        .foregroundColor(.white.opacity(0.7))
                            }
                            .textFieldStyle(getHFTextFieldStye(model.emailUiState))
                        SecureField("password".localized, text: $password)
                            .placeholder(when: password.isEmpty) {
                                    Text("search")
                                        .foregroundColor(.white.opacity(0.7))
                            }
                            .textFieldStyle(getHFTextFieldStye(model.passwordUiState))
                    }
                    
                    HStack{
                        Button {
                            guard !email.isEmpty else {
                                #warning("show banner for empty email")
                                return
                            }
                            
                            model.resetPassword(email: email)
                        } label: {
                            Text("forgot_password".localized)
                        }
                        Spacer()
                        Button {
                            model.signup()
                        } label: {
                            Text("sign_up".localized)
                        }
                    }
                    .foregroundColor(.gray)
                    .padding(.horizontal, 4)
                }
                Spacer()
                HafeflyButton {
                    model.login(email: email, password: password)
                } label: {
                    Text("sign_in".localized)
                        .font(.white, Font.HafeflyRubik.semiBold, 18)
                }.padding(.bottom, 24)
            }
            .padding(24)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
