//
//  HafeflyApp.swift
//  Hafefly
//
//  Created by Samy Mehdid on 5/3/2023.
//

import SwiftUI
import HFNavigation
import FirebaseCore

@main
struct HafeflyApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    private let coordinator = NavigationCoordinator.shared
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                StackTrigger(coordinator)
                    .onAppear {
                        coordinator.setStartPoint(SplashView())
                        LocationManager.shared.requestLocation()
                    }
            }
        }
    }
}
