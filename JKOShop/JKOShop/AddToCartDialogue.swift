//
//  AddToCartDialogue.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/9.
//

import Foundation
import UIKit

class AddToCartDialogue:UIViewController{
    
    var vm:ProductDetailVM?
    
    @IBAction func addToCartBtn(_ sender: BasicButton) {
        if let id = self.vm?.id{
            ShoppingCartManager.shared().addToCart(id: id,
                                                   count: self.vm!.count,
                                                   unitPrice: self.vm!.unitPrice)
        }
    }
}
