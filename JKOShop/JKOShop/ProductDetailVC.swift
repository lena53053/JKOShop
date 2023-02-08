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
import iCarousel

class ProductDetailVC: UIViewController, iCarouselDelegate, iCarouselDataSource{
    
    @IBOutlet weak var imageViewer: iCarousel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var decsLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var addToCartBtn: BasicButton!
    
    @IBOutlet weak var pageCounter: UIButton!
    
    private var timer:Timer?
    
    var vm = ProductDetailVM()
    
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeUI()
        self.vm.initializeData()

        
        
        self.vm.model
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { product in
                self.title = product?.name ?? ""
                self.titleLabel.text = product?.name ?? ""
                self.priceLabel.text = "$\(product?.price ?? 0)"
                self.decsLabel.text = product?.description ?? ""
                
                let stock = product?.stock ?? 0
                if stock == 0{
                    self.addToCartBtn.isEnabled = false
                }else{
                    self.stockLabel.text = "In Stock: \(stock)"
                }
                
                let formatter = DateFormatter("YYYY-MM-dd", secondsFromGMT: 0)
                self.createTimeLabel.text = "Created Time: \(formatter.string(from: product?.createTime ?? Date()))"
                
                if let imageCount = product?.imgLinkList?.count, imageCount != 0{
                    self.pageCounter.setTitle("1/\(imageCount)", for: .normal)
                }else{
                    self.pageCounter.isHidden = true
                }
                
                self.imageViewer.reloadData()
            }).disposed(by: disposeBag)
        
        self.addToCartBtn.rx.tap
//            .observe(on: MainScheduler.instance)
            .subscribe(onNext:{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "addToCartDialogue") as! AddToCartDialogue
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
//                if let product = self.vm.model.value, let id = product.id{
//                    ShoppingCartManager.shared().addToCart(id: id, count: 2)
//                }
            }).disposed(by: disposeBag)
    }
    
    func initializeUI(){
        self.setNavigationLeftBarItem()
        self.pageCounter.layer.cornerRadius = 5
        self.addToCartBtn.layer.cornerRadius = 24
        
        self.imageViewer.delegate = self
        self.imageViewer.dataSource = self
        self.imageViewer.isPagingEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return self.vm.model.value?.imgLinkList?.count ?? 0
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var itemView: UIImageView
        
        if let view = view as? UIImageView {
                    itemView = view
                } else {
                    itemView = UIImageView(frame: self.imageViewer.frame)
                    itemView.image = UIImage(named: "image_placeholder")
                    itemView.contentMode = .scaleAspectFit
                }
        return itemView
    }
    
    func carouselDidEndScrollingAnimation(_ carousel: iCarousel) {
        self.pageCounter.setTitle("\(carousel.currentItemIndex+1)/\(carousel.numberOfItems)", for: .normal)
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == .wrap{
            return 1
        }
        return value
    }
}
