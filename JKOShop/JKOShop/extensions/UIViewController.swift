//
//  UIViewController.swift
//  JKOShop
//
//  Created by Lena Lai on 2023/2/7.
//

import Foundation
import UIKit

extension UIViewController{
    func setupNavigationBar(){
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = UIColor.red
            appearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
            self.navigationController?.navigationBar.setNeedsLayout()
        }else{
            
//            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            
        }
    }
    
    func setNavigationLeftBarItem(){
        
        let back = UIBarButtonItem(image: UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate),
                                   style: .plain,
                                   target: self,
                                   action: #selector(UIViewController.leftBarButtonItemAction))

        self.navigationItem.setLeftBarButton(back, animated: false)
        
    }
    
    @objc func leftBarButtonItemAction() {
        navigationController?.popViewController(animated: true)
    }
}
