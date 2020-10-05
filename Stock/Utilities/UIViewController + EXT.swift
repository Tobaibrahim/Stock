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
    
    
    convertShirtValues { (longSleeveBlack, longSleeveWhite, shortSleeveWhite, shortSleeveBlack) in
        switch indexPath.row {
            
        case 0:
            //ShortSleeveBlack
            cell.smallLabelValue.text  = String(shortSleeveBlack[1])
            cell.mediumLabelValue.text = String(shortSleeveBlack[2])
            cell.LargeLabelValue.text  = String(shortSleeveBlack[0])
            cell.smallLabel.text  = sizes[0]
            cell.mediumLabel.text = sizes[1]
            cell.LargeLabel.text  = sizes[2]
            
        case 1:
            //ShortSleeveWhite
            cell.smallLabelValue.text  = String(shortSleeveWhite[1])
            cell.mediumLabelValue.text = String(shortSleeveWhite[2])
            cell.LargeLabelValue.text  = String(shortSleeveWhite[0])
            cell.smallLabel.text  = sizes[0]
            cell.mediumLabel.text = sizes[1]
            cell.LargeLabel.text  = sizes[2]
        case 2:
            //LongSleeveBlack
            cell.smallLabelValue.text  = String(longSleeveBlack[1])
            cell.mediumLabelValue.text = String(longSleeveBlack[2])
            cell.LargeLabelValue.text  = String(longSleeveBlack[0])
            cell.smallLabel.text  = sizes[0]
            cell.mediumLabel.text = sizes[1]
            cell.LargeLabel.text  = sizes[2]
            
        case 3:
            
            //LongSleeveWhite
            cell.smallLabelValue.text  = String(longSleeveWhite[1])
            cell.mediumLabelValue.text = String(longSleeveWhite[2])
            cell.LargeLabelValue.text  = String(longSleeveWhite[0])
            cell.smallLabel.text  = sizes[0]
            cell.mediumLabel.text = sizes[1]
            cell.LargeLabel.text  = sizes[2]
            
            
        case 4:
            //Beanie
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.Beanie)
            break
            
            
        case 5:
            //Cap
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.Cap)
            
        case 6:
            //Mask
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.Mask)
            
        case 7:
            //Tote
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.Tote)
            
        case 8:
            //PostageBag
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.PostalBag)
            
        case 9:
            //MaskPostageBag
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.MaskPostalBag)
            
        case 10:
            //ClearBag
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.ClearBag)
            
        case 11:
            //CustomsForm
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.CustomsForm)
            
        case 12:
            //CustomsFormTracked
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.CustomsFormTracked)
            
        case 13:
            //ThermalLabel
            stockDataResponse.isAccessory = true
            cell.mediumLabelValue.text = String(stockDataResponse.ThermalLabel)
            
            
        default:
            break
        }
        
    }
    
    return cell
}

func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let imageNamePath = stockDataResponse.shirtImages[indexPath.row]
    let shirtNamePath = stockDataResponse.shirtNames[indexPath.row]
    let destVC  = EditStocks()
    destVC.backgroundColour = stockDataResponse.coloursArray.randomElement()
    destVC.itemImageName    = imageNamePath
    destVC.itemName         = shirtNamePath // The item name for the text value
    
    convertShirtValues { (longSleeveBlack, longSleeveWhite, shortSleeveWhite, shortSleeveBlack) in
        // using the return values for the tshirts we pass the s,m,l labels to the databse values, I did this because we had to parse the dictionary data
        switch indexPath.row {
        case 0:
            // ShortSleeveBlack
            destVC.itemPathName     = stockNameArrayKeys[0]
            destVC.smallLabelValue  = shortSleeveBlack[1]
            destVC.mediumLabelValue = shortSleeveBlack[2]
            destVC.largeLabelValue  = shortSleeveBlack[0]
        case 1:
            // ShortSleeveWhite
            destVC.itemPathName     = stockNameArrayKeys[2]
            destVC.smallLabelValue  = shortSleeveWhite[1]
            destVC.mediumLabelValue = shortSleeveWhite[2]
            destVC.largeLabelValue  = shortSleeveWhite[0]
        case 2:
            //LongSleeveBlack
            destVC.itemPathName     = stockNameArrayKeys[7]
            destVC.smallLabelValue  = longSleeveBlack[1]
            destVC.mediumLabelValue = longSleeveBlack[2]
            destVC.largeLabelValue  = longSleeveBlack[0]
        case 3:
            //LongSleeveWhite
            destVC.itemPathName     = stockNameArrayKeys[3]
            destVC.smallLabelValue  = longSleeveWhite[1]
            destVC.mediumLabelValue = longSleeveWhite[2]
            destVC.largeLabelValue  = longSleeveWhite[0]
        case 4:
            //Beanie
            destVC.itemPathName     = stockNameArrayKeys[9]
            destVC.smallLabelValue  = stockDataResponse.Beanie
            destVC.isAccessory      = true
            
        case 5:
            //Cap
            destVC.itemPathName     = stockNameArrayKeys[4]
            destVC.smallLabelValue  = stockDataResponse.Cap // using the response data to add the default value to the edit view
            destVC.isAccessory      = true
        case 6:
            //Mask
            destVC.itemPathName     = stockNameArrayKeys[1]
            destVC.smallLabelValue  = stockDataResponse.Mask
            destVC.isAccessory      = true
        case 7:
            //Tote
            destVC.itemPathName     = stockNameArrayKeys[12]
            destVC.smallLabelValue  = stockDataResponse.Tote
            destVC.isAccessory      = true
            
            
        case 8:
            //PostageBag
            destVC.itemPathName     = stockNameArrayKeys[8]
            destVC.smallLabelValue  = stockDataResponse.PostalBag
            destVC.isAccessory      = true
            
            
        case 9:
            //MaskPostageBag
            destVC.itemPathName     = stockNameArrayKeys[6]
            destVC.smallLabelValue  = stockDataResponse.MaskPostalBag
            destVC.isAccessory      = true
            
            
        case 10:
            //ClearBag
            destVC.itemPathName     = stockNameArrayKeys[13]
            destVC.smallLabelValue  = stockDataResponse.ClearBag
            destVC.isAccessory      = true
            
        case 11:
            //CustomsForm
            destVC.itemPathName     = stockNameArrayKeys[11]
            destVC.smallLabelValue  = stockDataResponse.CustomsForm
            destVC.isAccessory      = true
            
            
        case 12:
            //CustomsFormTracked
            destVC.itemPathName     = stockNameArrayKeys[5]
            destVC.smallLabelValue  = stockDataResponse.CustomsFormTracked
            destVC.isAccessory      = true
            
            
        case 13:
            //ThermalLabel
            destVC.itemPathName     = stockNameArrayKeys[10]
            destVC.smallLabelValue  = stockDataResponse.ThermalLabel
            destVC.isAccessory      = true
            
        default:
            break
        }
        
        
        
        
    }
    let navController = UINavigationController(rootViewController: destVC)
    present(navController, animated: true)
}

//extension Array where Element: Hashable {
//    func difference(from other: [Element]) -> [Element] {
//        let thisSet = Set(self)
//        let otherSet = Set(other)
//        return Array(thisSet.symmetricDifference(otherSet))
//    }
//}
}
