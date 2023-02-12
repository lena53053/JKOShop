//
//  PaymentVM.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/12.
//

import Foundation

class PaymentVM: NSObject{
    
    var payingOrderList:[CartItem]? = nil{
        didSet{
            if let list = payingOrderList{
                self.totalPrice = self.calTotalPrice(list)
                
            }
        }
    }
    var selectedItemList:[String]?
    
    var totalPrice:Int = 0
    
    func calUnitNetPrice(count:Int, unitPrice:Int) -> Int{
        return count*unitPrice
    }
    
    func calTotalPrice(_ cartUnitPriceList:[CartModel], selectedItemList: [String]) -> Int{
        let calTotal = cartUnitPriceList.filter{ data in selectedItemList.contains(where: { data.id == $0 })}.reduce(0, {
            return $0 + $1.unitPrice*$1.count
        })
        
        return Int(calTotal)
    }
    
    func calTotalPrice(_ orderList:[CartItem]) -> Int{
        return orderList.reduce(0, {$0 + ($1.product?.price ?? 0)*$1.count})
    }
}
