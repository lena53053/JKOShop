//
//  PaymentManager.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/12.
//

import Foundation
import UIKit
import CoreData

class PaymentManager: NSObject{
    private static var inst : PaymentManager?
    
    class func shared() -> PaymentManager{
        guard let share = inst else{
            inst = PaymentManager()
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
    
    func payOrder(list: [CartItem], total:Int){
        let id = "\(Date().timeIntervalSince1970)"
        self.saveOrderHistory(id: id, itemList: list, total: total)
        self.refreshProductStock(itemList: list)
    }
    
    func saveOrderHistory(id:String, itemList:[CartItem], total:Int){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "OrderHistoryEntity", into: moc) as! OrderHistoryModel
        newItem.id = id
        newItem.timeStamp = Date()
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(itemList)
            
            var jsonString = String(data: jsonData, encoding: .utf8)
            newItem.orderDetail = jsonString
            newItem.totalPrice = Int64(total)
            
            try moc.save()
        }catch{
            print(error)
        }
    }
    
    func refreshProductStock(itemList:[CartItem]){
        if let productList = ProductManager.shared().productList{
            for item in itemList{
                if let firstIndex = productList.firstIndex(where: {$0.id == item.product?.id}){
                    ProductManager.shared().productList![firstIndex].stock! -= item.count
                }
            }
        }
    }

}
