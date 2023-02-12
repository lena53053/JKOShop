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
            appearance.backgroundColor = UIColor(named: "CC0000")
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
    
    func setNavigationRightCloseBarItem(){
        let close = UIBarButtonItem(image: UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate),
                                    style: .plain,
                                    target: self,
                                    action: #selector(UIViewController.rightCloseBarButtonItemAction))
        close.tintColor = .white
        self.navigationItem.setRightBarButton(close, animated: true)
    }
    
    @objc func rightCloseBarButtonItemAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func showToast(_ msg: String){
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2-100, y: self.view.frame.size.height/2, width: 200, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.text = msg
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.3, delay: 1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
