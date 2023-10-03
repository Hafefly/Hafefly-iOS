//
//  HafeflyTextField.swift
//  Hafefly
//
//  Created by Samy Mehdid on 7/3/2023.
//

import SwiftUI

struct HafeflyTextFieldStyle: TextFieldStyle {
    
    @State var uiState: UiState<String> = .idle
    
    init(uiState: UiState<String>) {
        self.uiState = uiState
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        switch uiState {
        case .idle:
            configBuilder(configuration: configuration, color: .hafeflyLightBlue)
        case .loading:
            configBuilder(configuration: configuration, color: .hafeflyLightBlue)
        case .success(let message):
            configBuilder(configuration: configuration, message: message, color: .green)
        case .failed(let error):
            configBuilder(configuration: configuration, message: error, color: .red)
        }
    }
    
    @ViewBuilder
    private func configBuilder(configuration: TextField<Self._Label>, message: String? = nil, color: Color) -> some View {
        VStack{
            configuration
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .foregroundColor(.hafeflyLightBlue)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(color, lineWidth: 4)
                )
                .cornerRadius(8)
                .shadow(color: color, radius: 10)
            
            if let message = message {
                Text(message)
                    .font(color, .medium, 14)
            }
        }
    }
}
