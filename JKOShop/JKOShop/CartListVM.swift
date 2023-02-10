//
//  CartListVM.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/11.
//

import Foundation
import RxSwift
import RxCocoa

struct CartItem{
    var product: ProductModel?
    var count: Int = 0
}

class CartListVM : NSObject{
    
    var cartUnitPriceList:[CartModel] = []
    
    var cartItemList = BehaviorRelay<[CartItem]>(value: [])
    var selectedItemList = BehaviorRelay<[String]>(value: [])
    
    var totalPrice = BehaviorRelay<Int>(value: 0)
    
    var disposeBag = DisposeBag()
    
    func initializeData(){
        ShoppingCartManager.shared().cartList
            .subscribe(onNext: { list in
                if let productList = ProductManager.shared().productList, list != nil{
                    self.cartUnitPriceList = list!
                    
                    if self.cartItemList.value.count == 0, list!.count != 0{
                        let idList = list!.compactMap{ $0.id }
                        self.selectedItemList.accept(idList)
                    }
                    
                    let cartProductList = productList.filter{ cart in list!.contains(where: {$0.id == cart.id })}
                    
                    let combinedData = cartProductList.map{ item in CartItem( product: item, count: Int(list!.first(where: { $0.id == item.id})?.count ?? 0))}

                    self.cartItemList.accept(combinedData)
                }
            }).disposed(by: self.disposeBag)
        
        self.selectedItemList
            .subscribe(onNext: { list in
                let calTotal = self.cartUnitPriceList.filter{ data in list.contains(where: { data.id == $0 })}.reduce(0, {
                    return $0 + $1.unitPrice*$1.count
                })
                
                self.totalPrice.accept(Int(calTotal))
        }).disposed(by: disposeBag)
    }
    
    func checkSelectionStatus(id: String){
        var selectedList = self.selectedItemList.value
        if let index = selectedList.firstIndex(where: { $0 == id}){
            selectedList.remove(at: index)
            self.selectedItemList.accept(selectedList)
        }else{
            selectedList.append(id)
            self.selectedItemList.accept(selectedList)
        }
        
    }
    
}
