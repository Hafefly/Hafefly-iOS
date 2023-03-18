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
    
    @State private var username: String = ""
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
                        TextField("username".localized, text: $username)
                        SecureField("password".localized, text: $password)
                        SecureField("re_enter_password".localized, text: $rePassword)
                    }
                    .textFieldStyle(HafeflyTextFieldStyle())
                }
                Spacer()
                HafeflyButton {
                    model.signUp(firstname: firstname, lastname: lastname, province: province, phonenumber: phonenumber, username: username, password: password, rePassword: rePassword)
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
