//
//  View.swift
//  Hafefly
//
//  Created by Samy Mehdid on 7/3/2023.
//

import SwiftUI
import HFNavigation

extension View {
    func setupDefaultBackHandler() -> some View {
        self.modifier(BackHandlerModifier())
    }
    
    func setupBackHandler(_ handler: NavigationBackHandler) -> some View {
        self.modifier(BackHandlerModifier(handler))
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

extension View {
    func getHFTextFieldStye(_ uiState: UiState<String>) -> HafeflyTextFieldStyle {
        switch uiState {
        case .idle, .loading:
            return .init(color: .hafeflyLightBlue)
        case .success(let message):
            return .init(color: .green, message: message)
        case .failed(let error):
            return .init(color: .red, message: error)
        }
    }
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

//MARK: - Back hadling (due to swipe)
private struct BackHandlerModifier: ViewModifier, NavigationBackHandler {
    let handler: NavigationBackHandler?
    
    init(_ handler: NavigationBackHandler? = nil) {
        self.handler = handler
    }
    
    func popScreenDueToSwipe() {
        NavigationCoordinator.popBack()
    }
    
    @EnvironmentObject private var screenInfo: ScreenInfo
    
    func body(content: Content) -> some View {
       content
            .onAppear {
                screenInfo.backHandler = handler ?? self
            }
    }
}
