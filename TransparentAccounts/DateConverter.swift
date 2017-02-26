//
//  DateConverter.swift
//  TransparentAccounts
//
//  Created by Jan Strejc on 26/02/2017.
//  Copyright © 2017 Jan Strejc. All rights reserved.
//

import Foundation

class DateConverter {
    
    static func dateFromString(_ dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }
        
        let isoFormatter = ISO8601DateFormatter()
        var date = isoFormatter.date(from: dateString)
        if date == nil {
            let simpleFormatter = DateFormatter()
            simpleFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" // Fallback to incomplete date definiton, eg: 2016-09-07T10:00:06
            simpleFormatter.timeZone = TimeZone.init(identifier: "UTC")
            date = simpleFormatter.date(from: dateString)
        }
        return date
    }
}
