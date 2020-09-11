//
//  CustomImageView.swift
//  Stock
//
//  Created by TXB4 on 10/09/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//
import UIKit

class CustomImageView: UIImageView {


override init(frame: CGRect) {
    super.init(frame:frame)
    configure()
}

required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}

private func configure() {
    
    guard let avatarPlaceholder = UIImage(named: "longsleevewhiteshirt") else {
        print("Check Image Name!")
        
        return
    }
    
    layer.cornerRadius = 10
    clipsToBounds      = true
    image              = avatarPlaceholder
    translatesAutoresizingMaskIntoConstraints = false
    contentMode = .scaleAspectFill
}
}
