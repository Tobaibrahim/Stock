//
//  TextField.swift
//  Stock
//
//  Created by TXB4 on 10/09/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//



import UIKit

class TextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholderText:String,passwordEntry:Bool,borderColour:CGColor,textColour:UIColor) {
        super.init(frame:.zero)
        self.attributedPlaceholder       = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor:UIColor.white.withAlphaComponent(1)])
        self.isSecureTextEntry = passwordEntry
        self.layer.borderColor = borderColour
        self.textColor         = textColour
        configure()
    }
    
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius          = 18
        layer.borderWidth           = 2
        
        tintColor                   = .white
        textAlignment               = .center
        font                        = UIFont.preferredFont(forTextStyle: .headline)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 20
        returnKeyType               = .go
        backgroundColor             = nil
        autocorrectionType          = .no
        
        
    }
    
}
