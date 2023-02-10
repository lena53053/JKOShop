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
    var imageScrollPause = false
    
    var id:String?
    
    var model = BehaviorRelay<ProductModel?>(value: nil)
    var count = 1
    var unitPrice = 0
    var disposeBag = DisposeBag()
    
    func initializeData(){
        if let id = id{
            if let product = ProductManager.shared().fetchProductBy(id: id){
                
                self.unitPrice = product.price ?? 0
                self.model.accept(product)
            }
        }
    
    }
}
