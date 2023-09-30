//
//  LoginViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 6/3/2023.
//

import Foundation
import HFNavigation

extension LoginView {
    class Model: ObservableObject {
        func login(username: String, password: String) {
            LoginRepo.login(username: username, password: password) { token in
                KeychainHelper.standard.accessToken = token
                NavigationCoordinator.shared.switchStartPoint(MainView(tab: .home))
            } failure: { error in
                #warning("show banner error")
            }
        }
        
        func signup() {
            NavigationCoordinator.pushScreen(SignUpInfoView())
        }
    }
}
