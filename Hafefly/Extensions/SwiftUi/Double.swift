//
//  Double.swift
//  Hafefly
//
//  Created by Samy Mehdid on 8/3/2023.
//

import Foundation

extension Double {
    func rating(_ round: Int = 1) -> String {
        if self > Double(Int(self)) {
            return String(format: "%.\(round)f", self)
        } else {
            return String(format: "%.0f", self)
        }
    }
}
