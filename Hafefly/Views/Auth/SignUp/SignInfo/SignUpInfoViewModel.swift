//
//  SignInfoViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 7/3/2023.
//

import Foundation
import HFNavigation

extension SignUpInfoView {
    class Model: ObservableObject {
        @Published var otpButtonText = "send_otp"
        @Published var otpButtonDisabled = false
        
        @Published public private(set) var firstnameUiState: UiState<String> = .idle
        @Published public private(set) var lastnameUiState: UiState<String> = .idle
        @Published public private(set) var phoneNumberUiState: UiState<String> = .idle
        
        func sendOtp(phonenumber: String) {
            self.otpButtonDisabled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 60){
                self.otpButtonDisabled = false
                self.otpButtonText = "resend_otp"
            }
            #warning("send otp here")
        }
        
        func verifyOtp(for phonenumber: String, code otpCode: String) -> Bool {
            #warning("verify otp here")
            
            return validatePhoneFormat(phonenumber)
        }
        
        @discardableResult
        func validateName(_ name: String) -> Bool {
            let nameRegex = "^[A-Za-z]+([ '-][A-Za-z]+)*$"
            
            return name.regexChecker(with: nameRegex)
        }
        
        func setFirstnameUiState(_ success: Bool) {
            if success {
                self.firstnameUiState = .success("name in correct format")
            } else {
                self.firstnameUiState = .failed("name format is wrong")
            }
        }
        
        func setLastnameUiState(_ success: Bool) {
            if success {
                self.lastnameUiState = .success("name in correct format")
            } else {
                self.lastnameUiState = .failed("name format is wrong")
            }
        }
        
        @discardableResult
        func validatePhoneFormat(_ number: String) -> Bool {
            let phoneRegex = #"^\d{10}$"#
            
            let result = number.regexChecker(with: phoneRegex)
            if result {
                self.phoneNumberUiState = .success("phone in correct format")
            } else {
                self.phoneNumberUiState = .failed("phone should contain 10 characters")
            }
            
            return result
        }
        
        func checkInfo(firstname: String, lastname: String, province: Province, phoneNumber: String, otpCode: String) {
            if validateName(firstname),
               validateName(lastname),
               verifyOtp(for: phoneNumber, code: otpCode) {
                NavigationCoordinator.pushScreen(SignUpView(firstname: firstname, lastname: lastname, province: province, phonenumber: phoneNumber))
            }
        }
    }
}
