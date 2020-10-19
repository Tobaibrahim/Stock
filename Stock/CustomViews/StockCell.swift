//
//  StockCell.swift
//  Stock
//
//  Created by TXB4 on 10/09/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit

class StockCell: UICollectionViewCell {
    
    static let reuseID = "ImageCell"
    
    let avatarImageView  = CustomImageView(frame:.zero)
    let titleLabel       = CustomTitleLabel(textAlignment: .center, fontsSize: 16)
    let smallLabel       = CustomTitleLabel(textAlignment: .left, fontsSize: 15)
    let mediumLabel      = CustomTitleLabel(textAlignment: .center, fontsSize: 15)
    let LargeLabel       = CustomTitleLabel(textAlignment: .right, fontsSize: 15)
    let smallLabelValue  = CustomTitleLabel(textAlignment: .left, fontsSize: 20)
    let mediumLabelValue = CustomTitleLabel(textAlignment: .center, fontsSize: 20)
    let LargeLabelValue  = CustomTitleLabel(textAlignment: .right, fontsSize: 20)
    
    let notificationIcon: UIView = {
        let notificationIcon = UIView()
        notificationIcon.translatesAutoresizingMaskIntoConstraints = false
        notificationIcon.backgroundColor = .systemPink
        notificationIcon.layer.cornerRadius = 20 / 2
                
        return notificationIcon
        
    }()
    
    
    
    override func prepareForReuse() {
        avatarImageView.image = nil
        titleLabel.text       = nil
        smallLabel.text       = nil
        mediumLabel.text      = nil
        LargeLabel.text       = nil
        smallLabelValue.text  = nil
        mediumLabelValue.text = nil
        LargeLabelValue.text  = nil
        notificationIcon.isHidden      = false
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        let views = [avatarImageView,titleLabel,smallLabel,mediumLabel,LargeLabel,smallLabelValue,mediumLabelValue,LargeLabelValue,notificationIcon]
        for views in views {
            addSubview(views)
        }
        
        let padding:CGFloat = 15
        contentView.backgroundColor = .systemRed
        contentView.layer.cornerRadius = 15
        avatarImageView.image = UIImage(named: "StockLogo")
        //        smallLabel.text  = "S"
        //        mediumLabel.text = "M"
        //        LargeLabel.text  = "L"
        
        NSLayoutConstraint.activate(
            [avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
             avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
             avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
             avatarImageView.heightAnchor.constraint(lessThanOrEqualTo: avatarImageView.widthAnchor),
             
             titleLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 5),
             titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
             titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
             titleLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        mediumLabel.centerX(inView: contentView, topAnchor: titleLabel.bottomAnchor, paddingTop: padding)
        smallLabel.centerX(inView: contentView, topAnchor: titleLabel.bottomAnchor, paddingTop: padding)
        smallLabel.anchor(leading: contentView.leadingAnchor,paddingLeft: 20)
        LargeLabel.centerX(inView: contentView, topAnchor: titleLabel.bottomAnchor, paddingTop: padding)
        LargeLabel.anchor(trailing: contentView.trailingAnchor,paddingRight: 20)
        
        mediumLabelValue.centerX(inView: contentView, topAnchor: mediumLabel.bottomAnchor, paddingTop: 5)
        smallLabelValue.centerX(inView: contentView, topAnchor: smallLabel.bottomAnchor, paddingTop: 5)
        smallLabelValue.anchor(leading: contentView.leadingAnchor,paddingLeft: 20)
        LargeLabelValue.centerX(inView: contentView, topAnchor: LargeLabel.bottomAnchor, paddingTop: 5)
        LargeLabelValue.anchor(trailing: contentView.trailingAnchor,paddingRight: 20)
        
        notificationIcon.setDimensions(width: 20, height: 20)
        notificationIcon.anchor(top: contentView.topAnchor, trailing: contentView.trailingAnchor, paddingTop: 10,paddingRight: 10)
        
        
        avatarImageView.dropShadow()
    }
    
    
    
    
}



//smallLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
//smallLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
//smallLabel.trailingAnchor.constraint(equalTo: mediumLabel.leadingAnchor, constant: -2),
//smallLabel.heightAnchor.constraint(equalToConstant: 20),
//
//mediumLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
//mediumLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
//mediumLabel.trailingAnchor.constraint(equalTo: LargeLabel.leadingAnchor, constant: -2),
//mediumLabel.heightAnchor.constraint(equalToConstant: 20),
//
//LargeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
//LargeLabel.leadingAnchor.constraint(equalTo: mediumLabel.trailingAnchor, constant: padding),
//LargeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
//LargeLabel.heightAnchor.constraint(equalToConstant: 20),
