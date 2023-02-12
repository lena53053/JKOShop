//
//  OrderHistoryVM.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/12.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

class OrderHistoryVM:NSObject{
    
    var orderHistoryList = BehaviorRelay<[OrderHistoryModel]>(value: [])
    
    func fetchOrderHistoryList(){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSFetchRequest<OrderHistoryModel>(entityName: "OrderHistoryEntity")
        let sort = NSSortDescriptor(key:"timeStamp", ascending: false)
        request.sortDescriptors = [sort]
        
        do{
            let result = try moc.fetch(request)
            print("Cart Item Count: \(result.count)")

            for (index, history) in result.enumerated(){
                result[index].cartItem =  self.converDetailType(jsonStr: history.orderDetail ?? "")
            }

            self.orderHistoryList.accept(result)
            
        }catch{
            print(error)
        }
    }
    
    func converDetailType(jsonStr: String) -> [CartItem]?{
        if let bodyData = jsonStr.data(using: .utf8){
            let decoder = JSONDecoder()
            do{
                let obj = try decoder.decode([CartItem].self, from: bodyData)
                return obj
            }catch{
                print("error \(error)")
            }
        }
        
        return nil
    }
}
