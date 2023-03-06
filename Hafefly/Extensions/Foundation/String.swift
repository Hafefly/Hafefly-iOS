//
//  String.swift
//  Hafefly
//
//  Created by Samy Mehdid on 5/3/2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
