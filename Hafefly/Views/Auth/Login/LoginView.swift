//
//  LoginView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 6/3/2023.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var model = Model()
    
    @State private var username: String = ""
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
                        TextField("username".localized, text: $username)
                        SecureField("password".localized, text: $password)
                    }
                    .textFieldStyle(HafeflyTextFieldStyle())
                    HStack{
                        Button {
                            //
                        } label: {
                            Text("forgot_password".localized)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("sign_up".localized)
                        }
                    }
                    .foregroundColor(.gray)
                    .padding(.horizontal, 4)
                }
                Spacer()
                HafeflyButton {
                    model.login(username: username, password: password)
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
