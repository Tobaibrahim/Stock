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
        self.isAccessory               = false
    }

}
