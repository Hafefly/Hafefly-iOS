//
//  HafeflyApp.swift
//  Hafefly
//
//  Created by Samy Mehdid on 5/3/2023.
//

import SwiftUI
import HFNavigation

@main
struct HafeflyApp: App {
    
    private let coordinator = NavigationCoordinator.shared
    var body: some Scene {
        WindowGroup {
            StackTrigger(coordinator)
                .onAppear {
                    LocationManager.shared.requestLocation()
                }
        }
    }
}
