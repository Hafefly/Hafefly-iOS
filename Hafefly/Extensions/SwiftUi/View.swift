//
//  View.swift
//  Hafefly
//
//  Created by Samy Mehdid on 7/3/2023.
//

import SwiftUI
import HFNavigation

extension View {
    func setupDefaultBackHandler(home: Bool = false) -> some View {
        self.modifier(BackHandlerModifier(popToHome: home, handler: nil))
    }
    
    func setupBackHandler(_ handler: NavigationBackHandler) -> some View {
        self.modifier(BackHandlerModifier(popToHome: false, handler: handler))
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

//MARK: - Back hadling (due to swipe)
private struct BackHandlerModifier: ViewModifier, NavigationBackHandler {
    let popToHome: Bool
    let handler: NavigationBackHandler?
    
    func popScreenDueToSwipe() {
        NavigationCoordinator.popBack(home: popToHome)
    }
    
//    @EnvironmentObject private var screenInfo: NavigationCoordinator.ScreenInfo
    
    func body(content: Content) -> some View {
       content
//            .onAppear {
//                screenInfo.backHandler = handler ?? self
//            }
    }
}
