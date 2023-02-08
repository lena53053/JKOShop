//
//  BasicButton.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/9.
//

import Foundation
import UIKit

enum BasicButtonStyle:Int{
    case basic = 1
}

class BasicButton : UIButton{
    
    var style:BasicButtonStyle = .basic
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!


    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    func setStyle(_ style:BasicButtonStyle){
        self.style = style
        
        switch style {
        case .basic:
            self.layer.borderWidth = 24
            self.backgroundColor = UIColor(named: "FF7E79")
            self.setTitleColor(UIColor.white, for: .normal)
            self.setTitleColor(UIColor.white, for: .selected)
        }
    }
    
    func setDisableStyle(_ style:BasicButtonStyle){
        switch style {
        case .basic:
            self.backgroundColor = UIColor.lightGray
            self.setTitleColor(UIColor.white, for: .normal)
            self.setTitleColor(UIColor.white, for: .selected)
        }
    }
    
    override var isEnabled: Bool{
        didSet{
            super.isEnabled = isEnabled
            
            if isEnabled{
                self.setStyle(self.style)
            }else{
                self.setDisableStyle(self.style)
            }
        }
    }
}
