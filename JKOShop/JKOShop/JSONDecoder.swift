//
//  JSONDecoder.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/6.
//

import Foundation
import CoreData

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}

extension JSONDecoder{
    convenience init(context: NSManagedObjectContext) {
            self.init()
        self.userInfo[.context] = context
    }
}
