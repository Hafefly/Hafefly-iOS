//
//  Text.swift
//  Hafefly
//
//  Created by Samy Mehdid on 5/3/2023.
//

import Foundation
import SwiftUI

extension Text {
    func font(_ color: Color, _ hafeflyFont: Font.HafeflyRubik, _ size: CGFloat) -> Text {
        switch hafeflyFont {
        case .regular:
            return self
                .font(.custom(Font.HafeflyRubik.regular.rawValue, size: size))
                .foregroundColor(color)
        case .medium:
            return self
                .font(.custom(Font.HafeflyRubik.medium.rawValue, size: size))
                .foregroundColor(color)
        case .semiBold:
            return self
                .font(.custom(Font.HafeflyRubik.semiBold.rawValue, size: size))
                .foregroundColor(color)
        case .bold:
            return self
                .font(.custom(Font.HafeflyRubik.bold.rawValue, size: size))
                .foregroundColor(color)
        }
    }
}
