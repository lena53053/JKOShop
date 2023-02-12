//
//  ConfirmPaymentVC.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/12.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

enum PaymentViewListType{
    case payment
    case history
}

class ConfirmPaymentVC:UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var confirmPaymentBtn: BasicButton!
    
    var disposeBag = DisposeBag()
    var vm = PaymentVM()
    
    var type:PaymentViewListType = .payment
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUI()
        
        let nib = UINib(nibName: "ConfirmOrderCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "confirmOrderCell")
    }
    
    func initializeUI(){
        self.setupNavigationBar()
        
        if type == .payment{
            self.title = "確認訂單"
            self.confirmPaymentBtn.setTitle("提交訂單", for: .normal)
        }else{
            self.confirmPaymentBtn.setTitle("返回歷史紀錄", for: .normal)
        }
        
        self.setNavigationRightCloseBarItem()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.totalPriceLabel.text = "$\(self.vm.totalPrice)"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.payingOrderList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "confirmOrderCell") as! ConfirmOrderCell
        if let list = self.vm.payingOrderList{
            let unitPrice = self.vm.calUnitNetPrice(count: list[indexPath.row].count, unitPrice: list[indexPath.row].product?.price ?? 0)
            cell.price = unitPrice
            cell.count = list[indexPath.row].count
            cell.titleLabel.text = list[indexPath.row].product?.name ?? ""
        }
        return cell
    }
    
    @IBAction func selectconfirmPayment(_ sender: BasicButton) {
        if type == .payment{
            if let list = self.vm.payingOrderList{
                PaymentManager.shared().payOrder(list: list, total: self.vm.totalPrice)
                ShoppingCartManager.shared().deleteFromtCart(idList: self.vm.selectedItemList  ?? [])
                self.dismiss(animated: true)
            }
        }else{
            self.dismiss(animated: true)
        }
    }
}
