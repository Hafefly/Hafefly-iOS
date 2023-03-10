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
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
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
