//
//  ProductListVC.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/7.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ProductListVC: UIViewController, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    
    var vm = ProductListVM()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        
        self.title = "商品列表"
        self.vm.initializeData()
        
        let nib = UINib(nibName: "ItemListCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "itemListCell")
        
        self.tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        self.vm.productList.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "itemListCell", cellType: ItemListCell.self)){ indexPath, item, cell in
                cell.promotionLabel.text = item.promoName
                cell.titleLabel.text = item.name
                cell.priceLabel.text = "$\(item.price ?? 0)"
            }.disposed(by: disposeBag)
        
        self.tableView.rx.modelSelected(ProductModel.self)
            .subscribe(onNext: { model in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "productDetailVC") as! ProductDetailVC
                vc.vm.id = model.id
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return
//    }
}
