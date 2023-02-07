//
//  ProductDetailVC.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/8.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ProductDetailVC: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var decsLabel: UILabel!
    
    var vm = ProductDetailVM()
    
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationLeftBarItem()
        self.vm.initializeData()
        
        self.vm.model
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { product in
                self.titleLabel.text = product?.name ?? ""
                self.priceLabel.text = "$\(product?.price ?? 0)"
                self.decsLabel.text = product?.description ?? ""
            }).disposed(by: disposeBag)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
