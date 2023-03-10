//
//  Date.swift
//  Hafefly
//
//  Created by Samy Mehdid on 10/3/2023.
//

import Foundation

extension Date {
    func getFormattedDate(format: String = "HH:mm") -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
