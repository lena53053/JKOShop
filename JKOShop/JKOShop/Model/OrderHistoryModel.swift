//
//  OrderHistoryModel.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/12.
//

import Foundation
import CoreData

class OrderHistoryModel: NSManagedObject, Codable{
    var cartItem:[CartItem]?
    
    enum CodingKeys: CodingKey {
        case id
        case timeStamp
        case orderDetail
        case totalPrice
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Date(), forKey: .timeStamp)
        try container.encode(id, forKey: .id)
        try container.encode(orderDetail, forKey: .orderDetail)
        try container.encode(totalPrice, forKey: .totalPrice)

    }

    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)
    }
    
    
}
