//
//  JSONDecoder.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/9.
//

import Foundation
import CoreData

extension JSONDecoder{
    func dateConvert(){
        let formatter = DateFormatter("YYYY-MM-dd'T'hh:mm:ss", secondsFromGMT: 0)

        self.dateDecodingStrategy = .formatted(formatter)
    }
    
    convenience init(context: NSManagedObjectContext) {
            self.init()
        self.userInfo[.context] = context
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}
