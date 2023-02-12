//
//  OrderHistoryVC.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/12.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class OrderHistoryVC:UIViewController, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    var vm = OrderHistoryVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUI()
        
        let nib = UINib(nibName: "OrderHistoryCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "orderHistoryCell")
        
        self.vm.orderHistoryList.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "orderHistoryCell", cellType: OrderHistoryCell.self)){ indexPath, item, cell in
                if let timeStamp = item.timeStamp{
                    cell.orderDate = timeStamp
                }
                
                cell.itemCount = item.cartItem?.count ?? 0
                cell.totalPrice = Int(item.totalPrice)
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(OrderHistoryModel.self)
            .subscribe(onNext: { model in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "confirmPaymentVC") as! ConfirmPaymentVC
                vc.vm.payingOrderList = model.cartItem ?? []
                vc.type = .history
                vc.modalPresentationStyle = .overCurrentContext
                let nav = UINavigationController(rootViewController: vc)
                self.present(nav, animated: true)
            }).disposed(by: disposeBag)
    }
    
    func initializeUI(){
        self.setupNavigationBar()
        self.title = "確認訂單"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.vm.fetchOrderHistoryList()
    }
}
