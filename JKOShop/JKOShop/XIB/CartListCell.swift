//
//  CartListCell.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/11.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CartListCell : UITableViewCell{
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var checkMarkBtn: UIButton!
    
    var reuseableDisposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    var isChecked:Bool = false{
        didSet{
            if isChecked{
                self.checkMarkBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            }else{
                self.checkMarkBtn.setImage(UIImage(systemName: "circle"), for: .normal)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reuseableDisposeBag = DisposeBag()
    }
}
