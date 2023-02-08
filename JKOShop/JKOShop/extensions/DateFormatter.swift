//
//  DateFormatter.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/9.
//

import Foundation
extension DateFormatter{
    convenience init(_ format: String, secondsFromGMT seconds: Int){
        self.init()
        
        self.calendar = Calendar(identifier: .gregorian)
        self.locale = Locale(identifier: "en_US_POSIX")
        self.timeZone = TimeZone(secondsFromGMT: seconds)

        self.dateFormat = format
    }
}
