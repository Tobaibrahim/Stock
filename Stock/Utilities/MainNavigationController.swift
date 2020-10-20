//
//  MainNavigationController.swift
//  Stock
//
//  Created by TXB4 on 10/09/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//


import UIKit
import Firebase



class MainNavigationController: UINavigationController {
    
    
    //MARK: - properties
    
    
    //MARK: - LifeCycle

    
    override func viewDidLoad() {
//        configureViewControllers()
        authenticateUserAndConfigureUI()
    }
    
    //MARK: - Helpers

    
    func configureViewControllers() {
//        fetchUsers()
        let stocks         = Stocks()
        stocks.title       = "Stocks"
        let editStocks     = EditStocks()
        editStocks.title   = "EditStocks"
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor     = Colours.appWhite
        appearance.titleTextAttributes = [.foregroundColor: Colours.appWhite]
        navigationBar.isTranslucent    = false
        viewControllers                =  [EditStocks(),Stocks()]
        UINavigationBar.appearance().shadowImage  = UIImage()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
       
        }

        
    func authenticateUserAndConfigureUI() {
        
        if Auth.auth().currentUser == nil {
            print("DEBUG: User is not logged in")
            DispatchQueue.main.async {
                // if the user isnt logged in then present the login view controller
                let nav =  UINavigationController(rootViewController: Login())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false, completion: nil)
            }
            
            
        } else if Auth.auth().currentUser != nil {
            configureViewControllers()
        }
            
        else {
            CustomAlertOnMainThread(title: "Login Failed", message: "User is logged in on onother device", buttonTitle: "Okay")
        }
    }
    
    
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                let nav =  UINavigationController(rootViewController: Login())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false, completion: nil)
            }
            
            print("DEBUG: User Logged out!")
        } catch let error {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
}
