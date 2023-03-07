//
//  CoordinatorStack.swift
//  Hafefly
//
//  Created by Samy Mehdid on 6/3/2023.
//

import SwiftUI

private struct GlobalNamespaceKey: EnvironmentKey {
    static var defaultValue: Namespace.ID? {
        nil
    }
}

extension EnvironmentValues {
    var globalNamespace: Namespace.ID? {
        get { self[GlobalNamespaceKey.self] }
        set { self[GlobalNamespaceKey.self] = newValue}
    }
}

extension CoordinatorView {
    struct StackTrigger: View {
        private let coordinator: NavigationCoordinator
        @ObservedConsumer private var stack: [NavigationCoordinator.ScreenInfo]
        @Namespace private var globalNamespace
        @Environment(\.layoutDirection) private var layoutDirection
        
        init(_ coordinator: NavigationCoordinator) {
            self.coordinator = coordinator
            _stack = coordinator.$curStack
        }
        
        var body: some View {
            ForEach(Array(zip(stack.indices, stack)), id: \.0) { index, item in
                let screen = ScreenFromInfo(item.screen)
                screen
                    .transition(item.animation.transition)
                    .zIndex(Double(index))
                    .environmentObject(item)
                    .disabled(index < stack.count - 1)
            }
            .environment(\.globalNamespace, globalNamespace)
            .simultaneousGesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
                .onEnded { value in
                    var needPop = false
                    if abs(value.translation.height) < abs(value.translation.width) {
                        if abs(value.translation.width) > 50.0 {
                            if value.translation.width < 0 {
                                print("swipeRightToLeft()")
                                if layoutDirection == .rightToLeft {
                                    needPop = true
                                }
                            } else if value.translation.width > 0 {
                                print("swipeLeftToRight()")
                                if layoutDirection == .leftToRight {
                                    needPop = true
                                }
                            }
                        }
                    }
                    
                    if needPop, let handler = coordinator.curStack.last?.backHandler {
                        handler.popScreenDueToSwipe()
                    }
                }
            )
        }
        
        @ViewBuilder
        private func ScreenFromInfo(_ screen: NavigationCoordinator.Screens) -> some View {
            switch screen {
            case .onBoarding: OnboardingView()
            case .login: LoginView()
            case .signupInfo: SignUpInfoView()
            case .signup(let firstname, let lastname, let province, let phonenumber): SignUpView(firstname: firstname, lastname: lastname, province: province, phonenumber: phonenumber)
            case .splash: SplashView()
            case .home: HomeView()
            }
        }
    }
}
