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
        
        func login(email: String, password: String) {
            
            Task {
                do {
                    
                    try await FirebaseAuth.shared.signIn(email: email, password: password)
                    
                    NavigationCoordinator.shared.switchStartPoint(MainView(tab: .home))
                    
                } catch {
                    #warning("show banner for error")
                }
            }
        }
        
        func resetPassword(email: String) {
            Task {
                do {
                    try await FirebaseAuth.shared.resetPassword(email: email)
                } catch {
                    #warning("show banner for error")
                }
            }
        }
        
        func signup() {
            NavigationCoordinator.pushScreen(SignUpInfoView())
        }
    }
}
