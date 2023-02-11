//
//  AddToCartDialogue.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/9.
//

import Foundation
import UIKit

class AddToCartDialogue:UIViewController{
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var addToCartBtn: BasicButton!
    
    var vm:ProductDetailVM?
    
    lazy var dimView: UIView = {
            let dimmedView = UIView()
            dimmedView.backgroundColor = .black.withAlphaComponent(0.6)
            dimmedView.frame = self.view.bounds
            dimmedView.alpha = 0
            
            return dimmedView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initializeUI()
    }
    
    func initializeUI(){
        self.bgView.layer.cornerRadius = 16
        self.addToCartBtn.layer.cornerRadius = 8
        
        self.countLabel.text = "\(self.vm?.count ?? 0)"
        
        if let model = self.vm?.model.value{
            self.stockLabel.text = "In Stock: \(model.stock ?? 0)"
            self.priceLabel.text = "$\(model.price ?? 0)"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        dimView.addGestureRecognizer(tap)
        
        view.addSubview(dimView)
        view.sendSubviewToBack(dimView)
        
        UIView.animate(withDuration: 0.3) {
            self.dimView.alpha = 1
        }
        
        super.viewDidAppear(animated)
    }
    
    @IBAction func addToCartBtn(_ sender: BasicButton) {
        if let id = self.vm?.id{
            ShoppingCartManager.shared().addToCart(id: id,
                                                   count: self.vm!.count,
                                                   unitPrice: self.vm!.unitPrice)
            self.dismiss(animated: false)
        }
    }
    
    @IBAction func selectMinusAmount(_ sender: UIButton) {
        if (self.vm?.count ?? 0) > 0{
            self.vm?.count -= 1
        }

        countLabel.text = "\(self.vm?.count ?? 0)"
        self.refreshPriceLabel()
    }
    
    @IBAction func selectAddAmount(_ sender: UIButton) {
        self.vm?.count += 1
        
        countLabel.text = "\(self.vm?.count ?? 0)"
        self.refreshPriceLabel()
    }
    
    func refreshPriceLabel(){
        let unitNetPrice = PaymentVM().calUnitNetPrice(count: self.vm?.count ?? 0,
                                                       unitPrice: self.vm?.unitPrice ?? 0)
        priceLabel.text = "$\(unitNetPrice)"
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil){
        self.dismiss(animated: false)
    }
}
