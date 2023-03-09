//
//  SignInfoViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 7/3/2023.
//

import Foundation

extension SignUpInfoView {
    class Model: ObservableObject {
        @Published var otpButtonText = "send_otp"
        @Published var otpButtonDisabled = false
        
        func sendOtp(phonenumber: String) {
            self.otpButtonDisabled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 60){
                self.otpButtonDisabled = false
                self.otpButtonText = "resend_otp"
            }
            #warning("send otp here")
        }
        
        func verifyOtp(for phonenumber: String, code otpCode: String, completion: @escaping (Bool) -> Void) {
            #warning("verify otp here")
            completion(true)
        }
    }
}
