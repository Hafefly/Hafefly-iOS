//
//  Color.swift
//  Hafefly
//
//  Created by Samy Mehdid on 5/3/2023.
//

import Foundation
import SwiftUI

extension Color {
    static let hafeflyDarkBlue = Color(red: 26/255, green: 28/255, blue: 45/255)
    static let hafeflyBlue = Color(red: 29/255, green: 42/255, blue: 164/255)
    static let hafeflyLightBlue = Color(red: 113/255, green: 164/255, blue: 214/255, opacity: 0.7)
    static let favoriteBlue = Color(red: 57/255, green: 65/255, blue: 128/255)
}

extension Color {
    func lighter(by percentage: CGFloat = 30.0) -> Color {
        return self.adjust(by: abs(percentage))
    }

    func darker(by percentage: CGFloat = 30.0) -> Color {
        return self.adjust(by: -1 * abs(percentage))
    }

    func adjust(by percentage: CGFloat = 30.0) -> Color {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return Color(red: Double(min(red + percentage/100, 1.0)),
                         green: Double(min(green + percentage/100, 1.0)),
                         blue: Double(min(blue + percentage/100, 1.0)),
                         opacity: Double(alpha))
        } else {
            return self
        }
    }
}
