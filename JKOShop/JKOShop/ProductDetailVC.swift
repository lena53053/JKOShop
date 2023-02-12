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
    @IBOutlet weak var proceedToPaymentBtn: BasicButton!
    
    @IBOutlet weak var paymentBgView: UIView!
    
    @IBOutlet weak var pageCounter: UIButton!
    
    private var timer:Timer?
    
    var vm = ProductDetailVM()
    
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeUI()
    
        self.vm.model
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { product in
                self.title = product?.name ?? ""
                self.titleLabel.text = product?.name ?? ""
                self.priceLabel.text = "$\(product?.price ?? 0)"
                self.decsLabel.text = product?.description ?? ""
                
                let stock = product?.stock ?? 0
                self.stockLabel.text = "In Stock: \(stock)"
                self.addToCartBtn.isEnabled = stock != 0
                
                let formatter = DateFormatter("YYYY-MM-dd", secondsFromGMT: 0)
                self.createTimeLabel.text = "Created Time: \(formatter.string(from: product?.createTime ?? Date()))"
                
                if let imageCount = product?.imgLinkList?.count, imageCount != 0{
                    self.pageCounter.setTitle("1/\(imageCount)", for: .normal)
                }else{
                    self.pageCounter.isHidden = true
                }
                
                self.imageViewer.reloadData()
            }).disposed(by: disposeBag)
    }
    
    func initializeUI(){
        self.setNavigationLeftBarItem()
        self.pageCounter.layer.cornerRadius = 5
        
        self.imageViewer.delegate = self
        self.imageViewer.dataSource = self
        self.imageViewer.isPagingEnabled = true
        
        paymentBgView.layer.shadowColor = UIColor.black.cgColor
        paymentBgView.layer.shadowOffset = CGSize(width: 0, height: 3)
        paymentBgView.layer.shadowOpacity = 0.1
        paymentBgView.layer.shadowOffset = .zero
        paymentBgView.layer.shadowRadius = 6
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.vm.initializeData()
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
    
    @IBAction func selectaddToCart(_ sender: BasicButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "addToCartDialogue") as! AddToCartDialogue
        vc.addToCartSuccess
            .subscribe(onNext: { _ in
                
                self.showToast("商品已加入購物車")
                
            }).disposed(by: vc.disposeBag)
        vc.modalPresentationStyle = .overFullScreen
        vc.vm = self.vm
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func selectProceedToPayment(_ sender: BasicButton) {
        let cartItem = CartItem(product: self.vm.model.value, count: 1)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "confirmPaymentVC") as! ConfirmPaymentVC
        vc.paymentSuccess
            .subscribe(onNext: { result in
                if result{
                    self.vm.initializeData()
                    self.showToast("訂單已付款成功")
                }
            }).disposed(by: vc.disposeBag)
        
        vc.vm.payingOrderList = [cartItem]
        vc.modalPresentationStyle = .overCurrentContext
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true)
    }
}
