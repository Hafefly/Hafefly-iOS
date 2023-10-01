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
        
        func signUp(firstname: String, lastname: String, province: Province, phonenumber: String, email: String, password: String) {
            
            Task {
                do {
                    let user = try await FirebaseAuth.shared.createUser(email: email, password: password)
                    
                    UserRepo.shared.createUser(user: user) { userID in
                        UserDefaults.standard.userData = user
                        
                        NavigationCoordinator.shared.switchStartPoint(MainView(tab: .home))
                    } failure: { error in
                        #warning("show banner for error")
                    }
                } catch {
                    #warning("show banner for error")
                }
            }
        }
    }
}
