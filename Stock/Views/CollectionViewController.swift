//
//  CollectionViewController.swift
//  Stock
//
//  Created by TXB4 on 05/10/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    
    let shirtImages       = ["blacktshirt","whitetshirt","longsleeveblackshirt","longsleevewhiteshirt","beanie","hat","mask","totebag","Postage Bag","Mask Postage Bag","Clear Bag","Customs Form","Customs Form Tracked","Thermal Labels"]
    
    let shirtNames        = ["Short Sleeve - Black","Short Sleeve - White","Long Sleeve - Black","Long Sleeve - White","Beanie","Cap","Mask","Totebag","Postage Bag","Mask Postage Bag","Clear Bag","Customs Form","Customs Form Tracked","Thermal Labels"]
    
    let masks             = "mask"
    let caps              = "cap"
    let beanie            = "beanie"
    let tote              = "tote"
    
    let white             = "White"
    let black             = "Black"
    let longSleeveLarge   = "Long Sleeve - Large"
    let longSleeveMedium  = "Long Sleeve - Medium"
    let longSleeveSmall   = "Long Sleeve - Small"
    let shortSleeveSmall  = "Short Sleeve - Small"
    let shortSleeveMedium = "Short Sleeve -Medium"
    let shortSleeveLarge  = "Short Sleeve - Large"
    
    let coloursArray  = [Colours.lime,Colours.loginBackground,Colours.loginButton,Colours.orange,Colours.peach,Colours.pink,Colours.teal,Colours.yellow]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView.register(StockCell.self, forCellWithReuseIdentifier:StockCell.reuseID)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return shirtNames.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sizes = ["S","M","L"]
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: StockCell.reuseID, for: indexPath) as! StockCell
        cell.contentView.backgroundColor = coloursArray.randomElement()
        
        cell.avatarImageView.image = UIImage(named: shirtImages[indexPath.row])
        cell.titleLabel.text  = shirtNames[indexPath.row]
        
        
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imageNamePath = shirtImages[indexPath.row]
        let shirtNamePath = shirtNames[indexPath.row]
        let destVC  = EditStocks()
        destVC.backgroundColour = coloursArray.randomElement()
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
    }
    
}
