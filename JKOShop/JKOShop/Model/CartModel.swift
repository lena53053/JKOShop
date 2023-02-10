//
//  CartModel.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/6.
//

import Foundation
import CoreData

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

class CartModel: NSManagedObject, Codable{
    enum CodingKeys: CodingKey {
       case count
       case id
        case unitPrice
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try container.encode(id, forKey: .id)
        try container.encode(unitPrice, forKey: .unitPrice)

    }

    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)
    }
}

