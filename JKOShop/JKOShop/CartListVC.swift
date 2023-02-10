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
    
    var vm = CartListVM()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "購物車"
        
        let nib = UINib(nibName: "CartListCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cartListCell")
        
        self.tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        self.vm.cartItemList.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "cartListCell", cellType: CartListCell.self)){ indexPath, item, cell in
                
                if let product = item.product{
                    cell.titleLabel.text = product.name ?? ""
                    cell.priceLabel.text = "$\(product.price ?? 0)"
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
                    }
                }
            }.disposed(by: disposeBag)
        
        self.tableView.rx.modelSelected(CartItem.self)
            .subscribe(onNext: { model in
                
            }).disposed(by: disposeBag)
        
        self.vm.initializeData()
    }
}
