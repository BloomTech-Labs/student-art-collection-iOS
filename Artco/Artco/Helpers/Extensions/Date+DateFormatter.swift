//
//  Date+DateFormatter.swift
//  Artco
//
//  Created by Mitchell Budge on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

extension Date {
    
    func localizedDescription(dateStyle: DateFormatter.Style = .medium,
                              timeStyle: DateFormatter.Style = .medium,
                           in timeZone : TimeZone = .current,
                              locale   : Locale = .current) -> String {
        Formatter.date.locale = locale
        Formatter.date.timeZone = timeZone
        Formatter.date.dateStyle = dateStyle
        Formatter.date.timeStyle = timeStyle
        return Formatter.date.string(from: self)
    }
    
    var fullDate: String   { localizedDescription(dateStyle: .full,   timeStyle: .none) }
}

extension Formatter {
    static let date = DateFormatter()
}

extension TimeZone {
    static let gmt = TimeZone(secondsFromGMT: 0)!
}
