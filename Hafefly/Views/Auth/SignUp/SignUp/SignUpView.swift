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
    
    @State private var isPasswordMatch: Bool?
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rePassword: String = "" {
        didSet {
            if password == rePassword {
                isPasswordMatch = true
            } else {
                isPasswordMatch = false
            }
        }
    }
    
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
                        SecureField("password".localized, text: $password)
                        SecureField("re_enter_password".localized, text: $rePassword)
                    }
                    .textFieldStyle(HafeflyTextFieldStyle())
                }
                Spacer()
                HafeflyButton {
                    if let isPasswordMatch = isPasswordMatch, isPasswordMatch {
                        model.signUp(firstname: firstname, lastname: lastname, province: province, phonenumber: phonenumber, email: email, password: password)
                    }
                } label: {
                    Text("sign_up".localized)
                        .font(.white, Font.HafeflyRubik.semiBold, 18)
                }.padding(.bottom, 24)
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
