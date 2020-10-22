//
//  NetworkManager.swift
//  Stock
//
//  Created by TXB4 on 24/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit
import OhhAuth

class NetworkManager {
    
    static let shared     = NetworkManager()
    let cache             = NSCache<NSString,UIImage>()
    private let baseURL   = "https://openapi.etsy.com/v2/"
    let key               = ""
    let secret            = ""
    var oauthToken        = ""
    var oauthTokenSecret  = ""
    var ouathVerifier     = ""
    private init () {}
    
    
    //    oauth_token=64b53208101e4aeb4e840d0f1eccca&oauth_token_secret=8fb89d2ce8
    
    func testRequestOne (completed:@escaping(Result<ShopTransactionsResponse,STErrors>) -> Void) {
        
        
        let cc = (key: key, secret: secret)
        let uc = (key: oauthToken, secret: oauthTokenSecret)
        
        let urlString = baseURL + "shops/TOCLO/transactions"
        
        var req = URLRequest(url: URL(string:urlString)!)
                
        req.oAuthSign(method: "GET", consumerCredentials: cc, userCredentials: uc)
    
        
        let task = URLSession.shared.dataTask(with: req) {data,response,error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
                
            }
            
            guard let data = data else {
                completed(.failure(.invalidDataResponse))
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let shopFeatured  = try decoder.decode(ShopTransactionsResponse.self, from: data)
                
                completed(.success(shopFeatured))
                print(response.statusCode)
                
            }
                
            catch {
                
                completed(.failure(.invalidDataResponse))
                print(error)
                print(data)
            }
        }
        
        task.resume()
    }
    
    
    
    
    
}
