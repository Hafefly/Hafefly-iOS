//
//  HafeflyTextField.swift
//  Hafefly
//
//  Created by Samy Mehdid on 7/3/2023.
//

import SwiftUI

struct HafeflyTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .autocorrectionDisabled()
            .autocapitalization(.none)
            .foregroundColor(.hafeflyLightBlue)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.hafeflyLightBlue, lineWidth: 4)
            )
            .cornerRadius(8)
            .shadow(color: .hafeflyLightBlue, radius: 10)
    }
}
