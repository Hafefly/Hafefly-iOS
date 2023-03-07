//
//  SignUpViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 6/3/2023.
//

import Foundation

extension SignUpView {
    class Model: ObservableObject {
        func signUp(firstname: String, lastname: String, province: Province, phonenumber: String, username: String, password: String){
            NavigationCoordinator.shared.switchStartPoint(.home)
        }
    }
}
