//
//  ProductManager.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/6.
//

import Foundation
import UIKit
import CoreData

class ProductManager: NSObject{
    private static var inst : ProductManager?
    
    class func shared() -> ProductManager{
        guard let share = inst else{
            inst = ProductManager()
            return inst!
        }
        
        return share
    }
    
    override init() {
        super.init()
    }
    
    class func destroy(){
        inst = nil
    }
 
    var productList:[ProductModel]?
    var categoryList:[String]?
    
    //載入假資料
    func importTestData(){
        if let productData = Bundle.main.url(forResource: "TestProductData", withExtension: "json"){
            do{
                let data = try Data(contentsOf: productData)
                let decoder = JSONDecoder()
                decoder.dateConvert()
                
                let result = try decoder.decode([ProductModel].self, from: data)
//                print(result)
                
                self.productList = result
            }catch{
                print("[JSON: Error \(error)]")
            }
        }
        
    }
    
    func fetchCategoryList(){
        
    }
    
    //取商品列表
    func fetchProductListBy(category: String?){
        
    }
    
    //取的單一筆資料

    func fetchProductBy(id:String) -> ProductModel?{
        return self.productList?.first(where: {$0.id == id})
    }
}
    
