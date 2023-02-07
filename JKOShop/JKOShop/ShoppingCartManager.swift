//
//  ShoppingCartManager.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/6.
//

import Foundation

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
    }
    
    class func destroy(){
        inst = nil
    }
    
    //新增商品到購物車
    func addToCart(id:Int, count:Int){
        
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
