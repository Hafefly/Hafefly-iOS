//
//  ErrorResponse.swift
//  Hafefly
//
//  Created by Samy Mehdid on 28/3/2023.
//

import Foundation

enum ErrorResponse {
    case unknownError
    case decodingError(ErrorBody = ErrorBody(403, "decoding_error".localized))
    case authenticationError(ErrorBody = ErrorBody(401, "authentication_error".localized))
    case responseError(ErrorBody = ErrorBody(-1, "something_went_wrong".localized))
}

struct ErrorBody {
    let code: Int
    let message: String
    
    init(_ code: Int,_ message: String) {
        self.code = code
        self.message = message
    }
}
