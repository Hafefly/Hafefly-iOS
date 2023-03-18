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
    
    private let base = "http://127.0.0.1:8080"
    
    private let session = Session()
    var credential = JWTCredential(accessToken: KeychainHelper.standard.accessToken ?? "", expiration: Date(timeIntervalSinceNow: 60 * 60))
    private let authenticator = JWTAuthenticator()
    
    private let timout: Double = 30
    
    private var interceptor: AuthenticationInterceptor<JWTAuthenticator> {
        return AuthenticationInterceptor(authenticator: authenticator, credential: credential)
    }
    
    func get<T: Decodable>(endpoint: String, body: [String: Any]? = nil, success: @escaping (T) -> Void, failure: @escaping (String) -> Void){
        MyLogger().info("http:url: \(base)\(endpoint)")
        
        let header: HTTPHeaders = [
            .authorization("Bearer \(credential.accessToken)")
        ]
        
        session.request("\(base)\(endpoint)", method: .get, parameters: body, encoding: URLEncoding.queryString, headers: header, interceptor: interceptor) { (urlRequest: inout URLRequest) in
            urlRequest.timeoutInterval = self.timout
            
        }.responseDecodable(of: T.self) { response in
            MyLogger().info("http:res: \(response.debugDescription)")
            
            guard let status = response.response?.statusCode else {
                failure("somthing_went_wrong".localized)
                return
            }
            
            switch status {
            case 200...299:
                switch response.result {
                case .success(let res):
                    success(res)
                case .failure(let error):
                    failure(error.errorDescription ?? "somthing_went_wrong".localized)
                    MyLogger().error(error.errorDescription)
                }
            default: failure("somthing_went_wrong".localized)
            }
        }
    }
    
    func post<T: Decodable>(endpoint: String, body: [String: Any], success: @escaping (T) -> Void, failure: @escaping (String) -> Void){
        MyLogger().info("http:url: \(base)\(endpoint)")
        MyLogger().info("http:body: \(body)")
        
        let header: HTTPHeaders = [
            .authorization("Bearer \(credential.accessToken)")
        ]
        
        session.request("\(base)\(endpoint)", method: .post, parameters: body, headers: header, interceptor: interceptor){ (urlRequest: inout URLRequest) in
            urlRequest.timeoutInterval = self.timout
            
        }.responseDecodable(of: T.self, emptyResponseCodes: [200]) { response in
            
            print("http:res: \(response.debugDescription)")
            
            guard let status = response.response?.statusCode else {
                failure("somthing_went_wrong".localized)
                return
            }
            
            switch status {
            case 200...299:
                switch response.result {
                case .success(let res):
                    success(res)
                case .failure(let error):
                    failure(error.errorDescription ?? "somthing_went_wrong".localized)
                    MyLogger().error(error.errorDescription)
                }
            default: failure("somthing_went_wrong".localized)
            }
        }
    }
}
