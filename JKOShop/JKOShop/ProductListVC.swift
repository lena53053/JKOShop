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
import Kingfisher


let TEMP_IMG_URL = "https://thumbs.dreamstime.com/b/portrait-adult-black-cat-white-background-quietly-sits-looks-aside-153205067.jpg"

class ProductListVC: UIViewController, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    
    var vm = ProductListVM()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        
        self.title = "商品列表"
        self.vm.initializeData()
        
        ShoppingCartManager.shared().cartBadgeNumber
            .subscribe(onNext: { badgeNum in
                if badgeNum == 0{
                    self.tabBarController?.tabBar.items?[1].badgeValue = nil
                }else{
                    self.tabBarController?.tabBar.items?[1].badgeValue = "\(badgeNum)"
                }
            }).disposed(by: disposeBag)
        
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
                
                cell.addToCartBtn.rx.tap
                    .subscribe(onNext: {
                        if let id = item.id{
                            ShoppingCartManager.shared().addToCart(id: id, count: 1, unitPrice: (item.price ?? 0))
                            self.showToast("商品已加入購物車")
                        }
                    }).disposed(by: cell.reuseableDisposeBag)
                
                cell.itemImageView.kf.setImage(with: URL(string: TEMP_IMG_URL),
                                                placeholder: UIImage(named: "image_placeholder"),
                                                options: [.transition(.fade(0.5)),
                                                          .onlyLoadFirstFrame,
                                                          .cacheMemoryOnly])
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
