//
//  ItemListCell.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/6.
//

import Foundation
import UIKit

class ItemListCell: UITableViewCell{
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var promotionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}
