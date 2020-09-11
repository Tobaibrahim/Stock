//
//  CustomBodyLabel.swift
//  Stock
//
//  Created by TXB4 on 10/09/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit


class CustomBodyLabel: UILabel {

override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(textAlignment:NSTextAlignment,fontsSize:CGFloat) {
    super.init(frame: .zero)
    configure()

    self.textAlignment = textAlignment
    self.font = UIFont.systemFont(ofSize: fontsSize, weight: .light)
    }
    
    
    private func configure () {
        textColor                 = .gray
        adjustsFontSizeToFitWidth = true
        font                      = UIFont.preferredFont(forTextStyle: .body)
        minimumScaleFactor        = 0.75
        lineBreakMode             = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines             = 4
    
    }
}


