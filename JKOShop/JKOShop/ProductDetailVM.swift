//
//  ProductDetailVM.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/8.
//

import Foundation
import RxSwift
import RxCocoa

class ProductDetailVM : NSObject{
    var id:String?
    var model = BehaviorRelay<ProductModel?>(value: nil)
    
    func initializeData(){
        if let id = id{
            if let product = ProductManager.shared().fetchProductBy(id: id){
                self.model.accept(product)
            }
        }
    }
}
