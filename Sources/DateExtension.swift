//
//  DateExtension.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 1/28/17.
//
//

import Foundation

extension Date {
    static func date(from string: String?, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        guard let dateString = string, let date = formatter.date(from: dateString) else{
            return nil
        }
        return date
    }
}
