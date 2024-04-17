//
//  DateFormated.swift
//  MangasLibrary
//
//  Created by Yery Castro on 19/3/24.
//

import Foundation

extension DateFormatter {
    static let dateFormat = {
            let date = DateFormatter()
            date.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            return date
        }()
}
