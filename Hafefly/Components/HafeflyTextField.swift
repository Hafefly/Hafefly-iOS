//
//  HafeflyTextField.swift
//  Hafefly
//
//  Created by Samy Mehdid on 7/3/2023.
//

import SwiftUI

struct HafeflyTextFieldStyle: TextFieldStyle {
    
    let color: Color
    var message: String?
    
    init(color: Color, message: String? = nil) {
        self.color = color
        self.message = message
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading){
            configuration
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .foregroundColor(.white)
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
                    .padding(.horizontal, 6)
            }
        }
    }
}
