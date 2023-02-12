//
//  ItemListCell.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/6.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ItemListCell: UITableViewCell{
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var promotionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var saveToFavBtn: UIButton!
    
    var reuseableDisposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reuseableDisposeBag = DisposeBag()
    }
}
