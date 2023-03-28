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
        let dateFormats = ["yyyy-MM-dd'T'HH:mm:ss'Z'", "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"]
        let dateFormatter = DateFormatter()
        for dateFormat in dateFormats {
            dateFormatter.dateFormat = dateFormat
            date = dateFormatter.date(from: self)
            if date != nil {
                break
            }
        }
        return date
    }
}
