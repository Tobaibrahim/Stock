//
//  StockQuantity.swift
//  Stock
//
//  Created by TXB4 on 10/09/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//


import UIKit


struct StockQuantity {

    
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
    let isAccessory            :Bool
    var isSmallTapped           = false
    var isMediumTapped          = false
    var isLargeTapped           = false
    var isAccessoryEditStocks   = false
    
    
    
    
        

    init(dictionary:[String:AnyObject]) {

        self.LongSleeveBlack           = dictionary["LongSleeveBlack"] as? [String:Int] ??  ["":0]
        self.ShortSleeveWhite          = dictionary["ShortSleeveWhite"] as? [String:Int] ??  ["":0]
        self.ShortSleeveBlack          = dictionary["ShortSleeveBlack"] as? [String:Int] ??   ["":0]
        self.LongSleeveWhite           = dictionary["LongSleeveWhite"] as? [String:Int] ??   ["":0]
        self.Mask                      = dictionary["Mask"] as? Int ??  0
        self.Cap                       = dictionary["Cap"] as? Int ??  0
        self.CustomsFormTracked        = dictionary["CustomsFormTracked"] as? Int ??  0
        self.MaskPostalBag             = dictionary["MaskPostalBag"] as? Int ??  0
        self.PostalBag                 = dictionary["PostalBag"] as? Int ??  0
        self.Beanie                    = dictionary["Beanie"] as? Int ??  0
        self.ThermalLabel              = dictionary["ThermalLabel"] as? Int ??  0
        self.CustomsForm               = dictionary["CustomsForm"] as? Int ??  0
        self.Tote                      = dictionary["Tote"] as? Int ??  0
        self.ClearBag                  = dictionary["ClearBag"] as? Int ??  0
        self.shirtImages             = ["blacktshirt","whitetshirt","longsleeveblackshirt","longsleevewhiteshirt","beanie","hat","mask","totebag","Postage Bag","Mask Postage Bag","Clear Bag","Customs Form","Customs Form Tracked","Thermal Labels"]
        
        self.shirtNames              = ["Short Sleeve - Black","Short Sleeve - White","Long Sleeve - Black","Long Sleeve - White","Beanie","Cap","Mask","Totebag","Postage Bag","Mask Postage Bag","Clear Bag","Customs Form","Customs Form Tracked","Thermal Labels"]
        
        self.masks                   = "mask"
        self.caps                    = "cap"
        self.beanie                  = "beanie"
        self.tote                    = "tote"
        self.white                   = "White"
        self.black                   = "Black"
        self.longSleeveLarge         = "Long Sleeve - Large"
        self.longSleeveMedium        = "Long Sleeve - Medium"
        self.longSleeveSmall         = "Long Sleeve - Small"
        self.shortSleeveSmall        = "Short Sleeve - Small"
        self.shortSleeveMedium       = "Short Sleeve -Medium"
        self.shortSleeveLarge        = "Short Sleeve - Large"
        self.coloursArray            = [Colours.lime,Colours.loginBackground,Colours.loginButton,Colours.orange,Colours.peach,Colours.pink,Colours.teal,Colours.yellow]
        self.isAccessory             = false
        
    }

}
