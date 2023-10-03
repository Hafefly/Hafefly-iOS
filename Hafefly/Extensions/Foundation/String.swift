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
    
    var parseDate: Date? {
        var date: Date?
        let dateFormat = "HH:mm'Z'"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        date = dateFormatter.date(from: self)
        return date
    }
    
    func regexChecker(with regex: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let range = NSRange(location: 0, length: self.utf16.count)
            let matches = regex.matches(in: self, options: [], range: range)
            
            return !matches.isEmpty
        } catch {
            return false
        }
    }
}
