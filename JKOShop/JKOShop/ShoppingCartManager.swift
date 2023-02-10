//
//  ShoppingCartManager.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/6.
//

import Foundation
import UIKit
import CoreData
import RxSwift
import RxCocoa

class ShoppingCartManager: NSObject{
    private static var inst : ShoppingCartManager?
    
    class func shared() -> ShoppingCartManager{
        guard let share = inst else{
            inst = ShoppingCartManager()
            return inst!
        }
        
        return share
    }
    
    override init() {
        super.init()
        
        self.fetchShoppingCartList()
    }
    
    class func destroy(){
        inst = nil
    }
    
    var cartBadgeNumber = BehaviorRelay<Int>(value: 0)
    var cartList = BehaviorRelay<[CartModel]?>(value: nil)
    
    func fetchShoppingCartList(){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSFetchRequest<CartModel>(entityName: "CartEntity")
        
        do{
            let result = try moc.fetch(request)
            print(result[0].count)
            self.cartBadgeNumber.accept(result.count)
            self.cartList.accept(result)
        }catch{
            print(error)
        }
    }
    
    //新增商品到購物車
    func addToCart(id:String, count:Int, unitPrice: Int){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSFetchRequest<CartModel>(entityName: "CartEntity")
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do{
            let result = try moc.fetch(request)
            
            if result.count > 0{
                result[0].count += Int64(count)
            }else{
                let newItem = NSEntityDescription.insertNewObject(forEntityName: "CartEntity", into: moc) as! CartModel
                newItem.id = id
                newItem.count = Int64(count)
                newItem.unitPrice = Int64(unitPrice)
            }
            
            try moc.save()
            
            self.fetchShoppingCartList()
        }catch{
            print(error)
        }
    }
    
    //修改商品數量
    func editItemCount(id:Int, count:Int){
        //不在需求範圍有空再做
    }
    
    //刪除購物車中的商品
    func deleteFromCart(id:Int){
        
    }
    
    //新增到我的最愛
    func addToFavorite(id:Int){
        //不在需求範圍有空再做
    }
    
    //從我的最愛中刪除
    func deleteFromFavorite(id:Int){
        //不在需求範圍有空再做
    }
    
    //算總金額
    func calculatePrice(){
        
    }
    
    //套用優惠券折扣
    func applyCoupon(){
        //不在需求範圍內有空再做
    }
}
