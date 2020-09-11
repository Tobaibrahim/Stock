//
//  UIViewController + EXT.swift
//  Stock
//
//  Created by TXB4 on 24/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import Foundation
import SafariServices


extension UIViewController {
    
    
    
    func CustomAlertOnMainThread(title:String,message:String,buttonTitle:String) {
        
        DispatchQueue.main.async {
            let alertVC = CustomAlert(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle   = .crossDissolve
            self.present(alertVC, animated: true)
        }
        
    }

func presentSafariVC(with url:URL) {
      
      let safariVC = SFSafariViewController(url: url)
      // safari view controller lets us access a safari website within our app instead of opening a new safari window
    safariVC.preferredControlTintColor = .systemGreen
      present(safariVC, animated: true)
  }
    
}


extension String {
       func deletingPrefix(_ prefix: String) -> String {
           guard self.hasPrefix(prefix) else { return self }
           return String(self.dropFirst(prefix.count))
       }
   }


extension UIView {



func anchor(top: NSLayoutYAxisAnchor? = nil,
            leading: NSLayoutXAxisAnchor? = nil,
            bottom: NSLayoutYAxisAnchor? = nil,
            trailing: NSLayoutXAxisAnchor? = nil,
            paddingTop: CGFloat = 0,
            paddingLeft: CGFloat = 0,
            paddingBottom: CGFloat = 0,
            paddingRight: CGFloat = 0,
            width: CGFloat? = nil,
            height: CGFloat? = nil) {
    
    translatesAutoresizingMaskIntoConstraints = false
    
    if let top = top {
        topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
    }
    
    if let left = leading {
        leadingAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
    }
    
    if let bottom = bottom {
        bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
    }
    
    if let right = trailing {
        trailingAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
    }
    
    if let width = width {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    if let height = height {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}

func center(inView view: UIView, yConstant: CGFloat? = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
}

func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    if let topAnchor = topAnchor {
        self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
    }
}

func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    
    centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
    
    if let leftAnchor = leftAnchor, let padding = paddingLeft {
        self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
    }
}

func setDimensions(width: CGFloat, height: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(equalToConstant: width).isActive = true
    heightAnchor.constraint(equalToConstant: height).isActive = true
}

func addConstraintsToFillView(_ view: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    anchor(top: view.topAnchor, leading: view.leftAnchor,
           bottom: view.bottomAnchor, trailing: view.rightAnchor)
}

    
    
}
