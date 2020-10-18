//
//  StockQuantityViewModel.swift
//  Stock
//
//  Created by TXB4 on 05/10/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit

struct StockQuantityViewModel {
    
    
    let LongSleeveBlack        : [String:Int]
    let ShortSleeveWhite       : [String:Int]
    let ShortSleeveBlack       : [String:Int]
    let LongSleeveWhite        : [String:Int]
    let Mask                   : Int
    let Cap                    : Int
    let CustomsFormTracked     : Int
    let MaskPostalBag          : Int
    let PostalBag              : Int
    let Beanie                 : Int
    let ThermalLabel           : Int
    let CustomsForm            : Int
    let Tote                   : Int
    let ClearBag               : Int
    var isAccessory            : Bool
    let shirtImages            :[String]
    let shirtNames             :[String]
    let coloursArray           :[UIColor]
    let masks                  :String
    let caps                   :String
    let beanie                 :String
    let tote                   :String
    let white                  :String
    let black                  :String
    let longSleeveLarge        :String
    let longSleeveMedium       :String
    let longSleeveSmall        :String
    let shortSleeveSmall       :String
    let shortSleeveMedium      :String
    let shortSleeveLarge       :String
    var isSmallTapped          :Bool
    var isMediumTapped         :Bool
    var isLargeTapped          :Bool
    var isAccessoryEditStocks  :Bool
    let images = [["Short Sleeve - Black":UIImage(named: "blacktshirt")],
                    ["Short Sleeve - White":UIImage(named: "whitetshirt")],
                    ["Long Sleeve - Black":UIImage(named: "longsleeveblackshirt")],
                    ["Long Sleeve - White":UIImage(named: "longsleevewhiteshirt")],
                    ["Beanie":UIImage(named: "beanie")],
                    ["Cap":UIImage(named: "hat")],
                    ["Mask":UIImage(named: "mask")],
                    ["Totebag":UIImage(named: "totebag")],
                    ["Postage Bag":UIImage(named: "Postage Bag")],
                    ["Mask Postage Bag":UIImage(named: "Mask Postage Bag")],
                    ["Clear Bag":UIImage(named: "Clear Bag")],
                    ["Customs Form":UIImage(named: "Customs Form")],
                    ["Customs Form Tracked":UIImage(named: "Customs Form Tracked")],
                    ["Thermal Labels":UIImage(named: "Thermal Labels")],]
      
      var filteredImages = [[String:UIImage]]()
      var issearching    = false
      var filter         = [[String:UIImage]]() // filter array

    
    
    
    
    
    
    
    
    
    init(stockQuantity:StockQuantity) {
        
        self.LongSleeveBlack           = stockQuantity.LongSleeveBlack
        self.ShortSleeveWhite          = stockQuantity.ShortSleeveWhite
        self.ShortSleeveBlack          = stockQuantity.ShortSleeveBlack
        self.LongSleeveWhite           = stockQuantity.LongSleeveWhite
        self.Mask                      = stockQuantity.Mask
        self.Cap                       = stockQuantity.Cap
        self.CustomsFormTracked        = stockQuantity.CustomsFormTracked
        self.MaskPostalBag             = stockQuantity.MaskPostalBag
        self.PostalBag                 = stockQuantity.PostalBag
        self.Beanie                    = stockQuantity.Beanie
        self.ThermalLabel              = stockQuantity.ThermalLabel
        self.CustomsForm               = stockQuantity.CustomsForm
        self.Tote                      = stockQuantity.Tote
        self.ClearBag                  = stockQuantity.ClearBag
        self.isAccessory               = stockQuantity.isAccessory
        self.shirtImages               = stockQuantity.shirtImages
        self.shirtNames                = stockQuantity.shirtNames
        self.masks                     = stockQuantity.masks
        self.caps                      = stockQuantity.caps
        self.beanie                    = stockQuantity.beanie
        self.tote                      = stockQuantity.tote
        self.white                     = stockQuantity.white
        self.black                     = stockQuantity.black
        self.longSleeveLarge           = stockQuantity.longSleeveLarge
        self.longSleeveMedium          = stockQuantity.longSleeveMedium
        self.longSleeveSmall           = stockQuantity.longSleeveSmall
        self.shortSleeveSmall          = stockQuantity.shortSleeveSmall
        self.shortSleeveMedium         = stockQuantity.shortSleeveMedium
        self.shortSleeveLarge          = stockQuantity.shortSleeveLarge
        self.coloursArray              = stockQuantity.coloursArray
        self.isSmallTapped             = false
        self.isMediumTapped            = false
        self.isLargeTapped             = false
        self.isAccessoryEditStocks     = false
        
    }
    
}
