//
//  CoordinatorView.swift
//  Hafefly
//
//  Created by Samy Mehdid on 6/3/2023.
//

import SwiftUI

public struct CoordinatorView: View {
    enum StartPoint {
        case onBoarding
        case login
        case main(Tabs)
    }
    
    let coordinator = NavigationCoordinator.shared
                                          
    public var body: some View {
        ZStack {
            StackTrigger(coordinator)
        }
    }
}
