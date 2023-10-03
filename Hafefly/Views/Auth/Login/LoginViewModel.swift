//
//  LoginViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 6/3/2023.
//

import SwiftUI
import HFNavigation

extension LoginView {
    class Model: ObservableObject {
        
        @Published public var emailUiState: UiState<String> = .idle
        @Published public var passwordUiState: UiState<String> = .idle
        
        func login(email: String, password: String) {
            Task {
                do {
                    try await FirebaseAuth.shared.signIn(email: email, password: password)
                    NavigationCoordinator.shared.switchStartPoint(MainView(tab: .home))
                    
                } catch {
                    self.emailUiState = .failed(error.localizedDescription)
                    self.passwordUiState = .failed(error.localizedDescription)
                }
            }
        }
        
        func resetPassword(email: String) {
            Task {
                do {
                    try await FirebaseAuth.shared.resetPassword(email: email)
                } catch {
                    self.emailUiState = .failed(error.localizedDescription)
                }
            }
        }
        
        func signup() {
            NavigationCoordinator.pushScreen(SignUpInfoView())
        }
    }
}
