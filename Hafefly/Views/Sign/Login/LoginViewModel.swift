//
//  LoginViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 6/3/2023.
//

import Foundation

extension LoginView {
    class Model: ObservableObject {
        func login(username: String, password: String) {
            NavigationCoordinator.shared.switchStartPoint(.home)
        }
        
        func signup() {
            NavigationCoordinator.pushScreen(.signupInfo)
        }
    }
}
