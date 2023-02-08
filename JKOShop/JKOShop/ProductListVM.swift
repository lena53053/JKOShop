//
//  ProductListVM.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/7.
//

import Foundation
import RxSwift
import RxCocoa

class ProductListVM : NSObject{
    var productList = BehaviorRelay<[ProductModel]>(value:[])
    
    func initializeData(){
        self.importTestData()
    }
    
    //載入假資料
    func importTestData(){
        if let productData = Bundle.main.url(forResource: "TestProductData", withExtension: "json"){
            do{
                let data = try Data(contentsOf: productData)
                let decoder = JSONDecoder()
                decoder.dateConvert()
                
                let result = try decoder.decode([ProductModel].self, from: data)
//                print(result)
                
                self.productList.accept(result)
            }catch{
                print("[JSON: Error \(error)]")
            }
        }
        
    }
}
