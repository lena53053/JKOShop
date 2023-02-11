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
        
        self.fetchCartList()
    }
    
    class func destroy(){
        inst = nil
    }
    
    var cartBadgeNumber = BehaviorRelay<Int>(value: 0)
    var cartList = BehaviorRelay<[CartModel]?>(value: nil)
    var selectedItemList = BehaviorRelay<[String]>(value: [])
    
    func fetchCartList(){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSFetchRequest<CartModel>(entityName: "CartEntity")
        
        do{
            let result = try moc.fetch(request)
            print("Cart Item Count: \(result.count)")
            self.cartBadgeNumber.accept(result.count)
            self.cartList.accept(result)
            
            if selectedItemList.value.count == 0{
                let idList = result.compactMap{ $0.id }
                self.selectedItemList.accept(idList)
            }
            
        }catch{
            print(error)
        }
    }
    
    //新增商品到購物車
    func addToCart(id: String, count:Int, unitPrice: Int){
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
                
                self.selectedItemList.accept(self.selectedItemList.value + [id])
            }
            
            try moc.save()
            
            self.fetchCartList()
        }catch{
            print(error)
        }
    }
    
    //修改商品數量
    func editItemCount(id:String, count:Int){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSFetchRequest<CartModel>(entityName: "CartEntity")
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do{
            let result = try moc.fetch(request)
            
            if result.count > 0{
                if count == 0{
                    moc.delete(result[0])
                }else{
                    result[0].count = Int64(count)
                }
            
                try moc.save()
                
                self.fetchCartList()
            }
        }catch{
            print(error)
        }
    }
    
    //刪除購物車中的商品
    func deleteFromCart(id:String){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSFetchRequest<CartModel>(entityName: "CartEntity")
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do{
            let result = try moc.fetch(request)
            
            if result.count > 0{
                moc.delete(result[0])
                
                try moc.save()
                
                self.fetchCartList()
            }
        }catch{
            print(error)
        }
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
