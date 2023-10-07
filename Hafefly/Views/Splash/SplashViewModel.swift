//
//  SplashViewModel.swift
//  Hafefly
//
//  Created by Samy Mehdid on 6/3/2023.
//

import Foundation
import CoreLocation
import HFNavigation

extension SplashView {
    class Model: ObservableObject {
        
        @Published public private(set) var uiState: UiState<HFUser> = .loading
        
        func getMe(status: CLAuthorizationStatus){
            switch status {
            case .notDetermined, .restricted, .denied:
                NavigationCoordinator.shared.switchStartPoint(OnboardingView())
            default:
                
                if nil != FirebaseAuth.shared.getUserId() {
                    NavigationCoordinator.shared.switchStartPoint(MainView())
                } else {
                    NavigationCoordinator.shared.switchStartPoint(LoginView())
                }
            }
        } //: getMe
        
    }
}
