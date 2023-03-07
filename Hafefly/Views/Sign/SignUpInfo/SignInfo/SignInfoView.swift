//
//  SignUpInfoView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 7/3/2023.
//

import SwiftUI

struct SignUpInfoView: View {
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var phonenumber: String = ""
    
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
                        TextField("firstname".localized, text: $firstname)
                        HStack{
                            TextField("firstname".localized, text: $firstname)
                            Text("resend_otp".localized)
                                .font(.white, .semiBold, 14)
                                .padding()
                                .frame(width: 100, height: 54)
                                .background(RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.hafeflyLightBlue))
                        }
                        
                    }.textFieldStyle(HafeflyTextFieldStyle())
                    HStack{
                        Text("forgot_password".localized)
                            .font(.white, .medium, 18)
                        Spacer()
                    }.padding(.horizontal, 8)
                }
                Spacer()
                    .frame()
                HafeflyButton {
                    continueSignUp(firstname: firstname, lastname: lastname, province: province, phonenumber: phonenumber)
                } label: {
                    Text("continue".localized)
                        .font(.white, .semiBold, 18)
                }.padding(.bottom, 24)
            }
            .padding()
        }
    }
    
    private func continueSignUp(firstname: String, lastname: String, province: Province, phonenumber: String){
        // Navigation
    }
}

struct SignUpInfo_Previews: PreviewProvider {
    static var previews: some View {
        SignUpInfoView()
    }
}
