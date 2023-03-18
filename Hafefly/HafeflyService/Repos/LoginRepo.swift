//
//  LoginRepo.swift
//  Hafefly
//
//  Created by Samy Mehdid on 16/3/2023.
//

import Foundation

class LoginRepo: NetworkService {
    private enum endpoints: String {
        case login = "/login"
        case signup = "/users/create"
    }
    
    static func login(username: String, password: String, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        let body: [String: String] = [
            "username": username,
            "password": password,
        ]
        shared.post(endpoint: endpoints.login.rawValue, body: body, success: success, failure: failure)
    }
    
    static func signUp(username: String, firstname: String, lastname: String, phone: String? = nil, email: String? = nil, province: String, password: String, confirmPassword: String, success: @escaping (String) -> Void, failure: @escaping (String) -> Void){
        let body: [String: String?] = [
            "username": username,
            "firstname": firstname,
            "lastname": lastname,
            "phone": phone,
            "email": email,
            "province": province,
            "password": password,
            "confirmPassword": confirmPassword
        ]
        shared.post(endpoint: endpoints.signup.rawValue, body: body as [String : Any], success: success, failure: failure)
    }
}
