//
//  SignUpViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 6/3/2023.
//

import Foundation
import HFNavigation

extension SignUpView {
    class Model: ObservableObject {
        
        func signUp(firstname: String, lastname: String, province: Province, phonenumber: String, username: String, password: String, rePassword: String){
            
            LoginRepo.signUp(username: username, firstname: firstname, lastname: lastname, province: province.rawValue, password: password, confirmPassword: rePassword) { token in
                
                KeychainHelper.standard.accessToken = token
                NavigationCoordinator.shared.switchStartPoint(MainView(tab: .home))
                
            } failure: { error in
                #warning("show banner for error")
            }
        }
    }
}
