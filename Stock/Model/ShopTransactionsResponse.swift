//
//  ShopTransactionsResponse.swift
//  Stock
//
//  Created by TXB4 on 24/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import Foundation


struct ShopTransactionsResponse:Decodable {
    
    
    let count: Int
    let results: [ShopTransactions]
    
}


struct ShopTransactions:Decodable {
    
    let price:String
//    let variations: [Value]
//    let propertyValues:
}


//struct Value: Decodable {
//
//    let formattedValue:[String]
//}
//
//struct <#name#> {
//    <#fields#>
//}
