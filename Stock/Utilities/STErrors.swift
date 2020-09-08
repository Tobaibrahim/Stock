//
//  STErrors.swift
//  Stock
//
//  Created by TXB4 on 24/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit

enum STErrors: String,Error {
    
    case invalidURL          = "This url is invalid"
    case unableToComplete    = "Unable to connect start url session"
    case invalidResponse     = "Invalid response from the http call"
    case invalidDataResponse = "Invalid data response from call"
}
