//
//  CartListVC.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/11.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CartListVC : UIViewController, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var proceedToPaymentBtn: BasicButton!
    @IBOutlet weak var paymentBgView: UIView!
    
    var vm = CartListVM()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeUI()
        
        self.title = "購物車"
        
        let nib = UINib(nibName: "CartListCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cartListCell")
        
        self.tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        self.vm.cartItemList.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "cartListCell", cellType: CartListCell.self)){ indexPath, item, cell in
                
                if let product = item.product{
                    let unitNetPrice = self.vm.payment_vm.calUnitNetPrice(count: item.count,
                                                                       unitPrice: (product.price ?? 0))
                    
                    cell.titleLabel.text = product.name ?? ""
                    cell.priceLabel.text = "$\(unitNetPrice)"
                    cell.countLabel.text = "\(item.count)"
                    
                    if let id = product.id{
                        self.vm.selectedItemList
                            .subscribe(onNext: { list in
                                cell.isChecked = list.contains(where: { $0 == id })
                            }).disposed(by: cell.reuseableDisposeBag)
                        
                        cell.checkMarkBtn.rx.tap
                            .subscribe(onNext: {
                                self.vm.checkSelectionStatus(id: id)
                            }).disposed(by: cell.reuseableDisposeBag)
                        
                        cell.deleteBtn.rx.tap
                            .subscribe(onNext: {
                                ShoppingCartManager.shared().deleteFromCart(id: id)
                            }).disposed(by: cell.reuseableDisposeBag)
                        
                        cell.minusBtn.rx.tap
                            .subscribe(onNext:{
                                ShoppingCartManager.shared().editItemCount(id: id, count: item.count-1)
                            }).disposed(by: cell.reuseableDisposeBag)
                        
                        cell.plusBtn.rx.tap
                            .subscribe(onNext:{
                                ShoppingCartManager.shared().editItemCount(id: id, count: item.count+1)
                            }).disposed(by: cell.reuseableDisposeBag)
                    }
                }
            }.disposed(by: disposeBag)
        
        
        
        self.vm.totalPrice
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { price in
                self.totalPriceLabel.text = "$\(price)"
                self.proceedToPaymentBtn.isEnabled = price != 0
            }).disposed(by: disposeBag)
        
        self.vm.initializeData()
    }
    
    func initializeUI(){
        self.proceedToPaymentBtn.layer.cornerRadius = 8
        
        paymentBgView.layer.shadowColor = UIColor.black.cgColor
        paymentBgView.layer.shadowOffset = CGSize(width: 0, height: 3)
        paymentBgView.layer.shadowOpacity = 0.1
        paymentBgView.layer.shadowOffset = .zero
        paymentBgView.layer.shadowRadius = 6
    }
}
