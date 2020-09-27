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
    
    let title:String
    let price:String
    let quantity:Int
    let variations: [Value]
    let tags:[String]
    let paidTsz:Int
    let receiptId: Int
    let transactionId:Int
    
}


struct Value: Decodable {
    
    let formattedValue:String?
}

