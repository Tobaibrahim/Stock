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

extension UIView {
    
    func addNotification() {
        let _: UIView = {
            let circle = UIView()
            circle.translatesAutoresizingMaskIntoConstraints = false
            circle.backgroundColor = .red
            //            circle.frame = CGRect(x: 50, y: 30, width: 30, height: 30)
            circle.layer.cornerRadius = 20 / 2
            NSLayoutConstraint.activate([
                circle.widthAnchor.constraint(equalToConstant: 20),
                circle.heightAnchor.constraint(equalToConstant: 20),
                
            ])
            return circle
        }()
        
        
    }
}

extension UIImageView {
    
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 20
        //        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.translatesAutoresizingMaskIntoConstraints = false
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

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}



extension Stocks:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return stockDataResponse.shirtNames.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sizes = ["S","M","L"]
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: StockCell.reuseID, for: indexPath) as! StockCell
        
        cell.contentView.backgroundColor = stockDataResponse.coloursArray.randomElement()
        cell.avatarImageView.image = UIImage(named: stockDataResponse.shirtImages[indexPath.row])
        cell.titleLabel.text  = stockDataResponse.shirtNames[indexPath.row]
        
        //    if stockDataResponse.issearching == true {cell.titleLabel.text = self.searchContacts[indexPath.row]}
        //    else {cell.titleLabel.text = nameArray[indexPath.row]}
        //    return cell
        
        
        
        switch indexPath.row {
            
        case 0:
            
            // These values match the databse indexes so thats why the n umbers vary... note to future self
            //ShortSleeveBlack
            cell.smallLabelValue.text  = String(shortSleeveBlack[2])
            cell.mediumLabelValue.text = String(shortSleeveBlack[1])
            cell.LargeLabelValue.text  = String(shortSleeveBlack[0])
            cell.smallLabel.text  = sizes[0]
            cell.mediumLabel.text = sizes[1]
            cell.LargeLabel.text  = sizes[2]
            
            if  shortSleeveBlack[2] != 0 || shortSleeveBlack[1] != 0 || shortSleeveBlack[0] != 0 {
                cell.notificationIcon.isHidden = true
            }
            
        case 1:
            //ShortSleeveWhite
            cell.smallLabelValue.text  = String(shortSleeveWhite[0])
            cell.mediumLabelValue.text = String(shortSleeveWhite[2])
            cell.LargeLabelValue.text  = String(shortSleeveWhite[1])
            cell.smallLabel.text  = sizes[0]
            cell.mediumLabel.text = sizes[1]
            cell.LargeLabel.text  = sizes[2]
            
            if  shortSleeveWhite[2] !=  0 || shortSleeveWhite[1] !=  0 || shortSleeveWhite[0] !=  0 {
                cell.notificationIcon.isHidden = true
            }
            
        case 2:
            //LongSleeveBlack
            cell.smallLabelValue.text  = String(longSleeveBlack[1])
            cell.mediumLabelValue.text = String(longSleeveBlack[2])
            cell.LargeLabelValue.text  = String(longSleeveBlack[0])
            cell.smallLabel.text  = sizes[0]
            cell.mediumLabel.text = sizes[1]
            cell.LargeLabel.text  = sizes[2]
            
            if  longSleeveBlack[2] !=  0 || longSleeveBlack[1] !=  0 || longSleeveBlack[0] != 0 {
                cell.notificationIcon.isHidden = true
            }
            
        case 3:
            
            //LongSleeveWhite
            cell.smallLabelValue.text  = String(longSleeveWhite[0])
            cell.mediumLabelValue.text = String(longSleeveWhite[1])
            cell.LargeLabelValue.text  = String(longSleeveWhite[2])
            cell.smallLabel.text  = sizes[0]
            cell.mediumLabel.text = sizes[1]
            cell.LargeLabel.text  = sizes[2]
            
            if  longSleeveWhite[2] !=  0 || longSleeveWhite[1] !=  0 || longSleeveWhite[0] !=  0 {
                cell.notificationIcon.isHidden = true
            }
            
            
        case 4:
            //Beanie
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.Beanie)
            
            if  stockDataResponse.Beanie !=  0 {
                cell.notificationIcon.isHidden = true
            }
            break
            
            
        case 5:
            //Cap
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.Cap)
            if  stockDataResponse.Cap !=  0 {
                cell.notificationIcon.isHidden = true
            }
            
        case 6:
            //Mask
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.Mask)
            if  stockDataResponse.Mask !=  0 {
                cell.notificationIcon.isHidden = true
            }
            
        case 7:
            //Tote
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.Tote)
            if  stockDataResponse.Tote !=  0 {
                cell.notificationIcon.isHidden = true
            }
            
        case 8:
            //PostageBag
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.PostalBag)
            if  stockDataResponse.PostalBag !=  0 {
                cell.notificationIcon.isHidden = true
            }
            
        case 9:
            //MaskPostageBag
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.MaskPostalBag)
            if  stockDataResponse.MaskPostalBag !=  0 {
                cell.notificationIcon.isHidden = true
            }
            
        case 10:
            //ClearBag
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.ClearBag)
            if  stockDataResponse.ClearBag !=  0 {
                cell.notificationIcon.isHidden = true
            }
            
        case 11:
            //CustomsForm
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.CustomsForm)
            if  stockDataResponse.CustomsForm !=  0 {
                cell.notificationIcon.isHidden = true
            }
            
        case 12:
            //CustomsFormTracked
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.CustomsFormTracked)
            if  stockDataResponse.CustomsFormTracked !=  0 {
                cell.notificationIcon.isHidden = true
            }
            
        case 13:
            //ThermalLabel
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.ThermalLabel)
            if  stockDataResponse.ThermalLabel !=  0 {
                cell.notificationIcon.isHidden = true
            }
            
            
        default:
            break
            
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imageNamePath = stockDataResponse.shirtImages[indexPath.row]
        let shirtNamePath = stockDataResponse.shirtNames[indexPath.row]
        let destVC  = EditStocks()
        destVC.backgroundColour  = stockDataResponse.coloursArray.randomElement()
        destVC.itemImageName     = imageNamePath
        destVC.itemName          = shirtNamePath // The item name for the text value
        
        // using the return values for the tshirts we pass the s,m,l labels to the databse values, I did this because we had to parse the dictionary data
        switch indexPath.row {
        case 0:
            
            // ShortSleeveBlack
            destVC.itemPathName     = stockNameArrayKeys[0]
            destVC.smallLabelValue  = shortSleeveBlack[2]
            destVC.mediumLabelValue = shortSleeveBlack[1]
            destVC.largeLabelValue  = shortSleeveBlack[0]
        case 1:
            // ShortSleeveWhite
            destVC.itemPathName     = stockNameArrayKeys[2]
            destVC.smallLabelValue  = shortSleeveWhite[0]
            destVC.mediumLabelValue = shortSleeveWhite[2]
            destVC.largeLabelValue  = shortSleeveWhite[1]
        case 2:
            //LongSleeveBlack
            destVC.itemPathName     = stockNameArrayKeys[7]
            destVC.smallLabelValue  = longSleeveBlack[1]
            destVC.mediumLabelValue = longSleeveBlack[2]
            destVC.largeLabelValue  = longSleeveBlack[0]
        case 3:
            //LongSleeveWhite
            destVC.itemPathName     = stockNameArrayKeys[3]
            destVC.smallLabelValue  = longSleeveWhite[0]
            destVC.mediumLabelValue = longSleeveWhite[1]
            destVC.largeLabelValue  = longSleeveWhite[2]
        case 4:
            //Beanie
            destVC.itemPathName     = stockNameArrayKeys[9]
            destVC.smallLabelValue  = stockDataResponse.Beanie
            stockDataResponse.isAccessoryEditStocks      = true
            destVC.isAccessory      = true
            
            
        case 5:
            //Cap
            destVC.itemPathName     = stockNameArrayKeys[4]
            destVC.smallLabelValue  = stockDataResponse.Cap // using the response data to add the default value to the edit view
            stockDataResponse.isAccessoryEditStocks      = true
            destVC.isAccessory      = true
            
        case 6:
            //Mask
            destVC.itemPathName     = stockNameArrayKeys[1]
            destVC.smallLabelValue  = stockDataResponse.Mask
            stockDataResponse.isAccessoryEditStocks      = true
            destVC.isAccessory      = true
            
        case 7:
            //Tote
            destVC.itemPathName     = stockNameArrayKeys[12]
            destVC.smallLabelValue  = stockDataResponse.Tote
            stockDataResponse.isAccessoryEditStocks      = true
            destVC.isAccessory      = true
            
            
        case 8:
            //PostageBag
            destVC.itemPathName     = stockNameArrayKeys[8]
            destVC.smallLabelValue  = stockDataResponse.PostalBag
            stockDataResponse.isAccessoryEditStocks      = true
            destVC.isAccessory      = true
            
            
            
        case 9:
            //MaskPostageBag
            destVC.itemPathName     = stockNameArrayKeys[6]
            destVC.smallLabelValue  = stockDataResponse.MaskPostalBag
            stockDataResponse.isAccessoryEditStocks      = true
            destVC.isAccessory      = true
            
            
            
        case 10:
            //ClearBag
            destVC.itemPathName     = stockNameArrayKeys[13]
            destVC.smallLabelValue  = stockDataResponse.ClearBag
            stockDataResponse.isAccessoryEditStocks      = true
            destVC.isAccessory      = true
            
            
        case 11:
            //CustomsForm
            destVC.itemPathName     = stockNameArrayKeys[11]
            destVC.smallLabelValue  = stockDataResponse.CustomsForm
            stockDataResponse.isAccessoryEditStocks      = true
            destVC.isAccessory      = true
            
            
            
        case 12:
            //CustomsFormTracked
            destVC.itemPathName     = stockNameArrayKeys[5]
            destVC.smallLabelValue  = stockDataResponse.CustomsFormTracked
            stockDataResponse.isAccessoryEditStocks      = true
            destVC.isAccessory      = true
            
            
            
        case 13:
            //ThermalLabel
            destVC.itemPathName     = stockNameArrayKeys[10]
            destVC.smallLabelValue  = stockDataResponse.ThermalLabel
            stockDataResponse.isAccessoryEditStocks      = true
            destVC.isAccessory      = true
            
            
        default:
            break
            
        }
        
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
}
