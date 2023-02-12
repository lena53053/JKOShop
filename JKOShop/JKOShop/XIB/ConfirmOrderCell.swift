//
//  ConfirmOrderCell.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/12.
//

import Foundation
import UIKit

class ConfirmOrderCell:UITableViewCell{
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    var count:Int = 0{
        didSet{
            self.countLabel.text = "x \(count)"
        }
    }
    
    var price:Int = 0{
        didSet{
            self.priceLabel.text = "$\(price)"
        }
    }
}
