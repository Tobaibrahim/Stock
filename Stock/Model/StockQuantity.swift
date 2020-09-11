//
//  StockQuantity.swift
//  Stock
//
//  Created by TXB4 on 10/09/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//


import UIKit


struct StockQuantity {

    
    let longSleeveBlackLarge   : Int
    let longSleeveBlackMedium  : Int
    let longSleeveBlackSmall   : Int
    let longSleeveWhiteLarge   : Int
    let longSleeveWhiteMedium  : Int
    let longSleeveWhiteSmall   : Int
    let shortSleeveBlackLarge  : Int
    let shortSleeveBlackMedium : Int
    let shortSleeveBlackSmall  : Int
    let shortSleeveWhiteLarge  : Int
    let shortSleeveWhiteMedium : Int
    let shortSleeveWhiteSmall  : Int

       

    init(dictionary:[String:AnyObject]) {

        self.longSleeveWhiteMedium     = dictionary["longSleeveWhiteMedium"] as? Int ?? 0
        self.longSleeveBlackMedium    = dictionary["longSleeveBlackMedium"] as? Int ?? 0
        self.longSleeveWhiteLarge     = dictionary["longSleeveWhiteLarge"] as? Int ?? 0
        self.longSleeveWhiteSmall     = dictionary["longSleeveWhiteSmall"] as? Int ?? 0
        self.shortSleeveBlackLarge     = dictionary["shortSleeveBlackLarge"] as? Int ?? 0
        self.shortSleeveWhiteMedium    = dictionary["shortSleeveWhiteMedium"] as? Int ?? 0
        self.shortSleeveBlackMedium   = dictionary["shortSleeveBlackMedium"] as? Int ?? 0
        self.shortSleeveWhiteLarge    = dictionary["shortSleeveWhiteLarge"] as? Int ?? 0
        self.shortSleeveBlackSmall   = dictionary["shortSleeveBlackSmall"] as? Int ?? 0
        self.longSleeveBlackSmall    = dictionary["longSleeveBlackSmall"] as? Int ?? 0
        self.shortSleeveWhiteSmall    = dictionary["shortSleeveWhiteSmall"] as? Int ?? 0
        self.longSleeveBlackLarge    = dictionary["longSleeveBlackLarge"] as? Int ?? 0


    }

}
