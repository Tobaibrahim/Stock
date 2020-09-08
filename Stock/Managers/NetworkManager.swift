//
//  NetworkManager.swift
//  Stock
//
//  Created by TXB4 on 24/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit
import OAuthSwift
import OhhAuth

class NetworkManager {
    
    static let shared     = NetworkManager()
    let cache             = NSCache<NSString,UIImage>()
    private let baseURL   = "https://openapi.etsy.com/v2/"
    let key               = "ej72ztgt3p04ddxrbuil4ixz"
    let secret            = "o51lx5449g"
    var oauthToken        = "64b53208101e4aeb4e840d0f1eccca"
    var oauthTokenSecret  = "8fb89d2ce8"
    var ouathVerifier     = "f699a4b8"
    private init () {}
    
    
//    oauth_token=64b53208101e4aeb4e840d0f1eccca&oauth_token_secret=8fb89d2ce8
    
    
    
    
    
    func testRequest() {
        
        
        
        
        
        let oauthswift = OAuth1Swift(consumerKey: key, consumerSecret: secret)
        
//        /shops/:shop_id/transactions

        let url = baseURL + "shops/TOCLO/transactions"
        
        oauthswift.client.get(url, completionHandler: <#T##OAuthSwiftHTTPRequest.CompletionHandler?##OAuthSwiftHTTPRequest.CompletionHandler?##(Result<OAuthSwiftResponse, OAuthSwiftError>) -> Void#>)
    }
    
    
    func authRequest(completed:@escaping(String,String,String) -> Void) {
        
        let oauthswift = OAuth1Swift(consumerKey: key, consumerSecret: secret)
        
        
        oauthswift.client.get("https://openapi.etsy.com/v2/oauth/request_token") {
            result in
            
            switch result {
            case .success(let response):
                guard let safeResponse = response.dataString()?.removingPercentEncoding else {return}
                let shortResponse = safeResponse.deletingPrefix("login_url=")
                print(shortResponse)
                
                let endIndex          = shortResponse.index(shortResponse.endIndex,offsetBy: -124)
                let startIndex        = shortResponse.index(shortResponse.startIndex,offsetBy: 149)
                let endIndex2         = shortResponse.index(shortResponse.endIndex,offsetBy: -94)
                let startIndex2       = shortResponse.index(shortResponse.startIndex,offsetBy: 199)
                
                let oauthTokenSecret = String(shortResponse[startIndex2...endIndex2])
                let oauthToken       = String(shortResponse[startIndex...endIndex])
                // set auth token and tokenSecret
                
                completed(shortResponse,oauthToken,oauthTokenSecret)
                // passed the result in completion handler
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
        
    }
    
    
    func obtainingTokenCredentials(verifier:String,authToken:String) {
        
        let oauthswift = OAuth1Swift(consumerKey: key, consumerSecret: secret)
        let oauthSignatureMethod = "HMAC-SHA1"
        let oauthTimestamp : String = String(Int(NSDate().timeIntervalSince1970))
        let oauthNonce: String = NSUUID().uuidString
        let oauthSignature = ""
        let url = "https://openapi.etsy.com/v2/oauth/access_token?oauth_consumer_key=\(key)&oauth_nonce=\(oauthNonce)&oauth_signature=\(oauthSignature)&oauth_signature_method=\(oauthSignatureMethod)&oauth_token=\(authToken)&oauth_timestamp=\(oauthTimestamp)&oauth_verifier=\(verifier)"
        

        oauthswift.client.get(url) {
                   result in

            print("ENDPOINT = \(url)")

                   switch result {
                   case .success(let response):
                       guard let safeResponse = response.dataString()?.removingPercentEncoding else {return}
                    
                       print(safeResponse)
                   case .failure(let error):
                       print(error.localizedDescription)

                   }
               }


        
        
    }
    
  
    
    
    
    
    
    
    
    //
    //    func getListingImages (for shop:String,pagination:String,completed:@escaping(Result<ListingsImagesResponse,STErrors>) -> Void) {
    //
    //        let endpoint = baseURL + "shops/\(shop)/listings/active?method=GET&api_key=\(key)&fields=title,url&limit=\(pagination)&includes=MainImage"
    //
    //        //      print(endpoint)
    //
    //        guard let url = URL(string: endpoint) else {
    //            completed(.failure(.invalidURL))
    //            return
    //        }
    //
    //        let task = URLSession.shared.dataTask(with: url) {data,response,error in
    //            if let _ = error {
    //                completed(.failure(.unableToComplete))
    //                return
    //            }
    //
    //            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
    //                completed(.failure(.invalidResponse))
    //                return
    //
    //            }
    //
    //            guard let data = data else {
    //                completed(.failure(.invalidDataResponse))
    //                return
    //            }
    //
    //            do {
    //
    //                let decoder = JSONDecoder()
    //                decoder.keyDecodingStrategy = .convertFromSnakeCase
    //
    //                let listingsImages  = try decoder.decode(ListingsImagesResponse.self, from: data)
    //
    //                completed(.success(listingsImages))
    //                print(response.statusCode)
    //
    //            }
    //
    //            catch {
    //
    //                completed(.failure(.invalidDataResponse))
    //                print("DEBUG: \(error.localizedDescription)")
    //                //              print(data)
    //            }
    //        }
    //
    //        task.resume()
    //    }
    //
    
    
    
    
    
    
    
}
