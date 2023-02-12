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
        
        self.drawBtn()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.drawBtn()
    }
    
    func drawBtn(){
        
        self.layer.cornerRadius = 8
    }
    
    func setStyle(_ style:BasicButtonStyle){
        self.style = style
        
        self.setEnabledStyle(style)
    }
    
    func setEnabledStyle(_ style:BasicButtonStyle){
        switch style {
        case .basic:
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
                self.setEnabledStyle(self.style)
            }else{
                self.setDisableStyle(self.style)
            }
        }
    }
}
