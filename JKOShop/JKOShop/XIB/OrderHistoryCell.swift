//
//  OrderHistoryCell.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/12.
//

import Foundation
import UIKit

class OrderHistoryCell:UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var orderDate:Date = Date(){
        didSet{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY年MM月dd日 HH:mm"
            self.dateLabel.text = dateFormatter.string(from: orderDate)
        }
    }
    
    var itemCount:Int = 0{
        didSet{
            countLabel.text = "\(itemCount) 樣商品"
        }
    }
    
    var totalPrice:Int = 0{
        didSet{
            self.priceLabel.text = "$\(totalPrice)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.dateLabel.text = ""
        self.selectionStyle = .none
    }
}
