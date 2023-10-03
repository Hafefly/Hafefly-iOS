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
        
        @Published public private(set) var emailUiState: UiState<String> = .idle
        @Published public private(set) var passwordUiState: UiState<String> = .idle
        @Published public private(set) var rePasswordUiState: UiState<String> = .idle
        
        func signUp(firstname: String, lastname: String, province: Province, phonenumber: String, email: String, password: String) {
            
            Task {
                do {
                    var user = try await FirebaseAuth.shared.createUser(email: email, password: password)
                    
                    user.firstname = firstname
                    user.lastname = lastname
                    user.province = province.rawValue
                    user.phone = phonenumber
                    user.email = email
                    user.haircutsDone = 0
                    user.vip = false
                    user.instagram = nil
                    user.profileImage = nil
                    
                    UserRepo.shared.createUser(user) { userID in
                        NavigationCoordinator.shared.switchStartPoint(MainView(tab: .home))
                    } failure: { error in
                        self.emailUiState = .failed(error)
                        self.passwordUiState = .failed(error)
                        self.rePasswordUiState = .failed(error)
                    }
                } catch {
                    self.emailUiState = .failed(error.localizedDescription)
                    self.passwordUiState = .failed(error.localizedDescription)
                    self.rePasswordUiState = .failed(error.localizedDescription)
                }
            }
        }
        
        @discardableResult
        func validateEmail(_ email: String) -> Bool {
            let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
            
            
            let result = email.regexChecker(with: emailRegex)
            if result {
                self.emailUiState = .success("email in correct format")
            } else {
                self.emailUiState = .failed("email must be of format: example@gmail.com")
            }
            
            return result
        }
        
        @discardableResult
        func validatePassword(_ password: String) -> Bool {
            let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
            
            
            let result = password.regexChecker(with: passwordRegex)
            if result {
                self.passwordUiState = .success("password in correct format")
            } else {
                self.passwordUiState = .failed("password must contain at least 8 characters, one uppercase, one lowercase, a number and a special character!")
            }
            return result
        }
        
        @discardableResult
        func passwordsCheck(password: String, rePassword: String) -> Bool {
            guard !rePassword.isEmpty else { return false }
            
            if rePassword == password {
                self.rePasswordUiState = .success("passwords match")
                return true
            } else {
                self.rePasswordUiState = .failed("passwords do not match")
                return false
            }
        }
        
        func validateEnteries(firstname: String, lastname: String, province: Province, phoneNumber: String, email: String, password: String, rePassword: String) {
            if validateEmail(email),
               validatePassword(password),
               passwordsCheck(password: password, rePassword: rePassword) {
                signUp(firstname: firstname, lastname: lastname, province: province, phonenumber: phoneNumber, email: email, password: password)
            }
        }
    }
}
