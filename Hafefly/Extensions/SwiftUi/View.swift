//
//  View.swift
//  Hafefly
//
//  Created by Samy Mehdid on 7/3/2023.
//

import SwiftUI

extension View {
    func setupDefaultBackHandler() -> some View {
        self.modifier(BackHandlerModifier())
    }
}

/// - Back hadling (due to swipe)
private struct BackHandlerModifier: ViewModifier, NavigationBackHandler {
    
    func popScreenDueToSwipe() {
        NavigationCoordinator.popBack()
    }
    
    @EnvironmentObject private var screenInfo: NavigationCoordinator.ScreenInfo
    
    func body(content: Content) -> some View {
       content
    }
}
