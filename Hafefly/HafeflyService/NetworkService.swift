//
//  NetworkService.swift
//  Hafefly
//
//  Created by Samy Mehdid on 16/3/2023.
//

import Foundation
import Alamofire

class NetworkService {
    static let shared = NetworkService()
    
    private let base = "https://r6y84.wiremockapi.cloud"
    
    private let session = Session()
    #warning("change value to user access token")
    var credential = JWTCredential(accessToken: "", expiration: Date(timeIntervalSinceNow: 60 * 60))
    private let authenticator = JWTAuthenticator()
    
    private let timout: Double = 30
    
    private var interceptor: AuthenticationInterceptor<JWTAuthenticator> {
        return AuthenticationInterceptor(authenticator: authenticator, credential: credential)
    }
    
    func get<T: Decodable>(endpoint: String, body: [String: Any]? = nil, success: @escaping (T) -> Void, failure: @escaping (ErrorResponse) -> Void){
        MyLogger().info("http:url: \(base)\(endpoint)")
        
        let header: HTTPHeaders = [
            .authorization("Bearer \(credential.accessToken)")
        ]
        
        session.request("\(base)\(endpoint)", method: .get, parameters: body, encoding: URLEncoding.queryString, headers: header, interceptor: interceptor) { (urlRequest: inout URLRequest) in
            urlRequest.timeoutInterval = self.timout
            
        }.responseDecodable(of: T.self) { response in
            MyLogger().info("http:res: \(response.debugDescription)")
            
            guard let status = response.response?.statusCode else {
                failure(.responseError())
                return
            }
            
            switch status {
            case 200...299:
                switch response.result {
                case .success(let res):
                    success(res)
                case .failure(let error):
                    failure(.decodingError())
                    MyLogger().error(error.errorDescription)
                }
            case 400...499:
                failure(.authenticationError())
            default: failure(.unknownError)
            }
        }
    }
    
    func post<T: Decodable>(endpoint: String, body: [String: Any], success: @escaping (T) -> Void, failure: @escaping (ErrorResponse) -> Void){
        MyLogger().info("http:url: \(base)\(endpoint)")
        MyLogger().info("http:body: \(body)")
        
        let header: HTTPHeaders = [
            .authorization("Bearer \(credential.accessToken)")
        ]
        
        session.request("\(base)\(endpoint)", method: .post, parameters: body, headers: header, interceptor: interceptor){ (urlRequest: inout URLRequest) in
            urlRequest.timeoutInterval = self.timout
            
        }.responseDecodable(of: T.self, emptyResponseCodes: [200]) { response in
            
            MyLogger().info("http:res: \(response.debugDescription)")
            
            guard let status = response.response?.statusCode else {
                failure(.responseError())
                return
            }
            
            switch status {
            case 200...299:
                switch response.result {
                case .success(let res):
                    success(res)
                case .failure(let error):
                    failure(.decodingError())
                    MyLogger().error(error.errorDescription)
                }
            case 400...499:
                failure(.authenticationError())
            default: failure(.unknownError)
            }
        }
    }
    
    func put(endpoint: String, body: [String: Any], success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void){
        MyLogger().info("http:url: \(base)\(endpoint)")
        MyLogger().info("http:body: \(body)")
        let header: HTTPHeaders = [
            .authorization("Bearer \(credential.accessToken)")
        ]
        session.request("\(base)\(endpoint)", method: .put, parameters: body, encoding: JSONEncoding.default, headers: header){ (urlRequest: inout URLRequest) in
            urlRequest.timeoutInterval = self.timout
        }.response(responseSerializer: .data) { response in
            MyLogger().info("http:res: \(response.debugDescription)")
            
            guard let status = response.response?.statusCode else {
                failure(.responseError())
                return
            }
            
            switch status {
            case 200...299:
                success()
            case 400...499:
                failure(.authenticationError())
            default: failure(.unknownError)
            }
        }
    }
    
    #warning("Implement DELETE methode")
}
