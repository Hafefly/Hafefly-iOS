//
//  HafeflyButton.swift
//  Hafefly
//
//  Created by Samy Mehdid on 6/3/2023.
//

import Foundation
import SwiftUI

struct HafeflyButton<Label: View>: View {
    private let action: () -> Void
    private let label: () -> Label
    private let foregroundColor: Color
    private let disabled: Bool
    private let radius: Double
    private let elevation: Double
    
    init(disabled: Bool = false, radius: Double = 8, foregroundColor: Color = .hafeflyLightBlue, elevation: Double = 0.5, action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Label){
        self.label = label
        self.action = action
        self.foregroundColor = foregroundColor
        self.disabled = disabled
        self.radius = radius
        self.elevation = elevation
    }
    
    var body: some View {
        Button(action: self.action) {
            self.label()
                .frame(maxWidth: .infinity, maxHeight: 55)
                .cornerRadius(radius)
                .background(RoundedRectangle(cornerRadius: radius).fill(disabled ? Color.gray : foregroundColor).shadow(radius: elevation))
        }
        .disabled(self.disabled)
    }
}

struct HafeflyButton_Previews: PreviewProvider {
    static var previews: some View {
        HafeflyButton {
            //
        } label: {
            Text("Get started")
                .font(.white, Font.HafeflyRubik.bold, 18)
        }
    }
}
