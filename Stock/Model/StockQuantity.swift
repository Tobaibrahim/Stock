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

    }

}
