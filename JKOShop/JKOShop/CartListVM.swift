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
    
    var payment_vm = PaymentVM()
    var disposeBag = DisposeBag()
    
    func initializeData(){
        ShoppingCartManager.shared().cartList
            .subscribe(onNext: { list in
                if let productList = ProductManager.shared().productList, list != nil{
                    self.cartUnitPriceList = list!
                    
                    let cartProductList = productList.filter{ cart in list!.contains(where: {$0.id == cart.id })}
                    
                    let combinedData = cartProductList.map{ item in CartItem( product: item, count: Int(list!.first(where: { $0.id == item.id})?.count ?? 0))}

                    self.cartItemList.accept(combinedData)
                }
            }).disposed(by: self.disposeBag)
        
        ShoppingCartManager.shared().selectedItemList
            .subscribe(onNext: { list in
                self.selectedItemList.accept(list)
            }).disposed(by: self.disposeBag)
        
        self.cartItemList
            .subscribe(onNext: { _ in
                self.refreshTotalPrice()
            }).disposed(by: disposeBag)
        
        self.selectedItemList
            .subscribe(onNext: { _ in
                self.refreshTotalPrice()
    
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
    
    func refreshTotalPrice(){
        let list = selectedItemList.value
        let calTotal = self.payment_vm.calTotalPrice(self.cartUnitPriceList, selectedItemList: list)
    
        self.totalPrice.accept(calTotal)
    }
}
