//
//  UInt.swift
//  Hafefly
//
//  Created by Samy Mehdid on 11/3/2023.
//

import Foundation

extension UInt {
    var toString: String {
        return String(self)
    }
    
    /// make sure to enter string arguments that are localized, let the function localize them
    func whichString(single: String, plural: String) -> String {
        if self == 1 {
            return single.localized
        } else {
            return plural.localized
        }
    }
}
