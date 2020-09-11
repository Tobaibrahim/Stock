//
//  UserService.swift
//  Stock
//
//  Created by TXB4 on 10/09/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit
import Firebase


struct UserService {
    
    static let shared = UserService()
    let ref           = Database.database().reference()
    

    func fetchStockQuantity(completion: @escaping(StockQuantity) -> Void) {
        ref.child("shirts").observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary    = snapshot.value as? [String:AnyObject] else {return}
            let snapshopValue       = snapshot.value as? NSDictionary
            let value = StockQuantity(dictionary: dictionary)
            print(snapshopValue?.allKeys)
            completion(value)

        }}
    
    
    func updateStockQuantity(shirtName:String,shirtValue:String) {
    
    let values = [shirtName:shirtValue]
        ref.child("shirts").child(shirtName).updateChildValues(values)
    }
        
    }
    
    



