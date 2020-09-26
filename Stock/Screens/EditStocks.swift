//
//  EditStocks.swift
//  Stock
//
//  Created by TXB4 on 09/09/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit
import Firebase


class EditStocks:UIViewController {
    
    //MARK: - Properties
    
    var backgroundColour:UIColor!
    var itemImageName:String!
    var itemPathName:String! // name of the item path to firebase child value
    var itemName:String! // name of the item text
    
    let itemImage      = CustomImageView(frame: .zero)
    let itemNameLabel  = CustomTitleLabel(textAlignment: .center, fontsSize: 24)
    let itemValueLabelSmall = CustomTitleLabel(textAlignment: .center, fontsSize: 64)
    let itemValueLabelMedium = CustomTitleLabel(textAlignment: .center, fontsSize: 64)
    let itemValueLabelLarge = CustomTitleLabel(textAlignment: .center, fontsSize: 64)
    let mediumLabel  = CustomTitleLabel(textAlignment: .center, fontsSize: 20)
    let smallLabel   = CustomTitleLabel(textAlignment: .center, fontsSize: 20)
    let largeLabel   = CustomTitleLabel(textAlignment: .center, fontsSize: 20)

    var isSmallTapped  = false
    var isMediumTapped = false
    var isLargeTapped  = false

    let plusButton     = CustomButton(backgroundColor: Colours.loginButton, title: "+", size: 10)
    let minusButton    = CustomButton(backgroundColor: Colours.loginButton, title: "-", size: 10)
    let saveButton     = CustomButton(backgroundColor: Colours.loginButton, title: "Save", size: 10)
    var smallLabelValue  = Int()
    var mediumLabelValue = Int()
    var largeLabelValue  = Int()
    
    var isAccessory     = false

    
    let containerView: UIView = {
    let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = Colours.appWhite
        container.layer.cornerRadius = 28
        container.isUserInteractionEnabled = true
    return container
    }()
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isAccessory == true {
            configureAccessoriesUI()
        }
        else {
        configureUI()
        }
    }
    
    
    //MARK: - Helpers
    
    
    
    func configureAccessoriesUI() {
        view.backgroundColor = backgroundColour ?? Colours.orange
        navigationController?.navigationBar.isHidden = true
        view.addSubview(itemImage)
        view.addSubview(saveButton)
        view.addSubview(containerView)
        
        let views = [itemNameLabel,itemValueLabelSmall,plusButton,minusButton,itemValueLabelMedium,itemValueLabelLarge,mediumLabel,smallLabel,largeLabel,]
        for values in views {
            containerView.addSubview(values)
        }
        
        itemImage.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 80)
        itemImage.setDimensions(width: 250, height: 250)
        itemImage.image = UIImage(named: itemImageName ?? "blacktshirt")
        
        saveButton.setDimensions(width: 72, height: 25)
        saveButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,trailing: view.trailingAnchor, paddingTop: 10, paddingRight: 30, width: 72, height: 25)
        saveButton.layer.cornerRadius = 6
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        
        containerView.anchor(leading: view.leadingAnchor, bottom: view.bottomAnchor,trailing: view.trailingAnchor, height: 375)
        
        plusButton.setDimensions(width: 250, height: 55)
        plusButton.centerX(inView: containerView, topAnchor: itemValueLabelSmall.bottomAnchor, paddingTop: 45)
        plusButton.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
        
        minusButton.setDimensions(width: 250, height: 55)
        minusButton.centerX(inView: containerView, topAnchor: plusButton.bottomAnchor, paddingTop: 12)
        minusButton.addTarget(self, action: #selector(minusButtonPressed), for: .touchUpInside)
        
        itemNameLabel.centerX(inView: containerView, topAnchor: containerView.topAnchor, paddingTop: 50)
        itemNameLabel.setDimensions(width: 226, height: 30)
        itemNameLabel.textColor = .black
        itemNameLabel.text = itemName ?? "Short Sleeve - Black"
        
        itemValueLabelSmall.centerX(inView: containerView, topAnchor: itemNameLabel.topAnchor, paddingTop: 50)
        let ValueLabelSmallTap = UITapGestureRecognizer(target: self, action: #selector(smallLabelTapped))
        itemValueLabelSmall.addGestureRecognizer(ValueLabelSmallTap)
        itemValueLabelSmall.setDimensions(width: 226, height: 80)
        itemValueLabelSmall.textColor = .black
        itemValueLabelSmall.text = String(smallLabelValue)
        
       
        smallLabel.centerX(inView: view, topAnchor: itemValueLabelSmall.topAnchor, paddingTop: 50)
        smallLabel.setDimensions(width: 150, height: 80)
        smallLabel.textColor = .black
        smallLabel.text  = "Qauntity"
       
        
    }
    
    
    func configureUI() {
        print("DEBUG: ITEM PATH NAME = \(itemPathName)")
        view.backgroundColor = backgroundColour ?? Colours.orange
        navigationController?.navigationBar.isHidden = true
        view.addSubview(itemImage)
        view.addSubview(saveButton)
        view.addSubview(containerView)
        
        let views = [itemNameLabel,itemValueLabelSmall,plusButton,minusButton,itemValueLabelMedium,itemValueLabelLarge,mediumLabel,smallLabel,largeLabel,]
        for values in views {
            containerView.addSubview(values)
        }
        
        itemImage.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 80)
        itemImage.setDimensions(width: 250, height: 250)
        itemImage.image = UIImage(named: itemImageName ?? "blacktshirt")
        
        saveButton.setDimensions(width: 72, height: 25)
        saveButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,trailing: view.trailingAnchor, paddingTop: 10, paddingRight: 30, width: 72, height: 25)
        saveButton.layer.cornerRadius = 6
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
      
        containerView.anchor(leading: view.leadingAnchor, bottom: view.bottomAnchor,trailing: view.trailingAnchor, height: 375)
        
        plusButton.setDimensions(width: 250, height: 55)
        plusButton.centerX(inView: containerView, topAnchor: itemValueLabelSmall.bottomAnchor, paddingTop: 45)
        plusButton.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)

        minusButton.setDimensions(width: 250, height: 55)
        minusButton.centerX(inView: containerView, topAnchor: plusButton.bottomAnchor, paddingTop: 12)
        minusButton.addTarget(self, action: #selector(minusButtonPressed), for: .touchUpInside)

        itemNameLabel.centerX(inView: containerView, topAnchor: containerView.topAnchor, paddingTop: 50)
        itemNameLabel.setDimensions(width: 226, height: 30)
        itemNameLabel.textColor = .black
        itemNameLabel.text = itemName ?? "Short Sleeve - Black"
        
        itemValueLabelSmall.centerX(inView: containerView, topAnchor: itemNameLabel.topAnchor, paddingTop: 50)
        let ValueLabelSmallTap = UITapGestureRecognizer(target: self, action: #selector(smallLabelTapped))
        itemValueLabelSmall.addGestureRecognizer(ValueLabelSmallTap)
        itemValueLabelSmall.setDimensions(width: 226, height: 80)
        itemValueLabelSmall.textColor = .black
        itemValueLabelSmall.text = String(smallLabelValue)

        
        itemValueLabelMedium.anchor(top: itemNameLabel.topAnchor, leading: view.leadingAnchor, paddingTop: 50, paddingLeft: 10)
        let ValueLabelMediumTap = UITapGestureRecognizer(target: self, action: #selector(mediumLabelTapped))
        itemValueLabelMedium.addGestureRecognizer(ValueLabelMediumTap)
        itemValueLabelMedium.setDimensions(width: 150, height: 80)
        itemValueLabelMedium.textColor = .black
        itemValueLabelMedium.text = String(mediumLabelValue)
        
        itemValueLabelLarge.anchor(top: itemNameLabel.topAnchor, trailing:view.trailingAnchor, paddingTop: 50, paddingRight: 10)
        let ValueLabelLargeTap = UITapGestureRecognizer(target: self, action: #selector(largeLabelTapped))
        itemValueLabelLarge.addGestureRecognizer(ValueLabelLargeTap)
        itemValueLabelLarge.setDimensions(width: 150, height: 80)
        itemValueLabelLarge.textColor = .black
        itemValueLabelLarge.text = String(largeLabelValue)

        
        smallLabel.centerX(inView: view, topAnchor: itemValueLabelSmall.topAnchor, paddingTop: 50)
        smallLabel.setDimensions(width: 150, height: 80)
        smallLabel.textColor = .black
        smallLabel.text  = "S"
        
        mediumLabel.anchor(top: itemValueLabelMedium.topAnchor, leading: view.leadingAnchor, paddingTop: 50, paddingLeft: 10)
        mediumLabel.setDimensions(width: 150, height: 80)
        mediumLabel.textColor = .black
        mediumLabel.text = "M"

        largeLabel.anchor(top: itemValueLabelLarge.topAnchor, trailing:view.trailingAnchor, paddingTop: 50, paddingRight: 10)
        largeLabel.setDimensions(width: 150, height: 80)
        largeLabel.textColor = .black
        largeLabel.text  = "L"
        
}
    
    
    @objc func smallLabelTapped () {
        isSmallTapped  = true
        isMediumTapped = false
        isLargeTapped  = false
        itemValueLabelSmall.textColor = .systemRed
        itemValueLabelLarge.textColor = .black
        itemValueLabelMedium.textColor = .black
        print("DEBUG: SMALL LABLEL TAPPED")
    }
    
    @objc func mediumLabelTapped () {
        isLargeTapped  = false
        isMediumTapped = true
        isSmallTapped  = false
        itemValueLabelMedium.textColor = .systemRed
        itemValueLabelLarge.textColor = .black
        itemValueLabelSmall.textColor = .black
        print("DEBUG: MEDIUM LABLEL TAPPED")

    }
    
    @objc func largeLabelTapped () {
        isLargeTapped  = true
        isMediumTapped = false
        isSmallTapped  = false
        itemValueLabelLarge.textColor = .systemRed
        itemValueLabelMedium.textColor = .black
        itemValueLabelSmall.textColor = .black
        print("DEBUG: LARGE LABLEL TAPPED")

    }
    

    
    @objc func plusButtonPressed () {
    print("plus button pressed")
        if isSmallTapped {
            smallLabelValue += 1
            itemValueLabelSmall.text = String(smallLabelValue)
        }
        
        if isMediumTapped {
            mediumLabelValue += 1
            itemValueLabelMedium.text = String(mediumLabelValue)
        }
        if isLargeTapped {
            largeLabelValue += 1
            itemValueLabelLarge.text = String(largeLabelValue)
        }
        
    }
    
    @objc func minusButtonPressed () {
    print("minus button pressed")
        if isSmallTapped {
            smallLabelValue -= 1
            itemValueLabelSmall.text = String(smallLabelValue)
        }
        
        if isMediumTapped {
            mediumLabelValue -= 1
            itemValueLabelMedium.text = String(mediumLabelValue)
        }
        if isLargeTapped  {
            largeLabelValue -= 1
            itemValueLabelLarge.text = String(largeLabelValue)
        }
    }
    
    
    @objc func saveButtonPressed () {
        print("save button pressed")
        
        if isLargeTapped || isMediumTapped || isSmallTapped{
            UserService.shared.updateShirtStockQuantity(Name: itemPathName, small: smallLabelValue, medium: mediumLabelValue, large: largeLabelValue)
            
            let name = Notification.Name(rawValue: notificationKeys.reloadCollectionView)
            NotificationCenter.default.post(name: name, object: nil)
        }
        
        
        if isAccessory && isSmallTapped {
            UserService.shared.updateAccessoryStockQuantity(Name: itemPathName, value: smallLabelValue)
            let name = Notification.Name(rawValue: notificationKeys.reloadCollectionView)
            NotificationCenter.default.post(name: name, object: nil)
        }
        
        
        // add the name
        dismiss(animated: true)
    }
    
}





//extension EditStocks:UIGestureRecognizerDelegate {
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
//        smallLabelTapped()
//        return true
//    }

