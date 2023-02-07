//
//  ProductModel.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/6.
//

import Foundation


struct ProductModel: Codable{
    var id:String?
    var name:String?
    var price: Int?
    var brand: String?
    var promoName: String?
    var stock:Int?
    var description: String?
    var tags: [String]?
    var imgLinkList: [String]?
    var category: [String]?
    
//    
//    enum CodingKeys: CodingKey {
//        case id
//        case name
//        case price
//        case brand
//        case promoName
//        case stock
//        case tags
//        case imgLinkList
//        case category
//        
//    }
    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(price, forKey: .price)
//        try container.encode(discount, forKey: .discount)
////        try container.encode(category, forKey: .category)
//
//    }
//
//    init() {
//
//    }
//
//    init(from decoder: Decoder) throws {
//    }

//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try values.decode(Int64.self, forKey: .id)
//        self.name = try values.decode(String.self, forKey: .name)
//        self.price = try values.decode(Int64.self, forKey: .price)
//        self.discount = (try? values.decode(Double.self, forKey: .discount)) ?? 0
//        self.category = try? values.decode(CategoryModel.self, forKey: .category)
}

