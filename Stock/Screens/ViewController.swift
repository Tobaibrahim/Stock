//
//  ViewController.swift
//  Stock
//
//  Created by TXB4 on 24/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit
import OhhAuth

class ViewController: UIViewController {
    
    
    
    //MARK: - Properties
    
    var isDifferentOrder:Bool!
    var recieptID = Int()
    
    var dataResponse: ShopTransactionsResponse! {
        didSet {
            print("DATA SET")
//            getTshirts()
            getAccessories()
        }
        
    }
    
    var responseURL     = String()
    var authToken       = String()
    var authTokenSecret = String()
    var randomArray     = ["one"]
    
    enum itemInfoType {
        
        case shortSleeveBlackSmall,shortSleeveBlackMedium,shortSleeveBlackLarge,shortSleeveWhiteSmall,shortSleeveWhiteMedium,shortSleeveWhiteLarge,longSleeveBlackSmall,longSleeveBlackMedium,longSleeveBlackLarge,longSleeveWhiteSmall,longSleeveWhiteMedium,longSleeveWhiteLarge
    }
    
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.setDimensions(width: 300, height: 50)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .systemBlue
        
        
        return tf
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setDimensions(width: 300, height: 40)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemRed
        button.setTitleColor(UIColor.white, for: .normal)
        
        
        return button
        
    }()
    
    
    let connectButton: UIButton = {
        let button = UIButton()
        button.setDimensions(width: 300, height: 40)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.setTitleColor(UIColor.white, for: .normal)
        
        
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    func configureUI() {
        view.backgroundColor = .systemGray2
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(connectButton)
        
        
        textField.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 100)
        button.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 300)
        connectButton.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 500)
        
    }
    
    
    
    func getData() {
        NetworkManager.shared.testRequestOne { (result) in
            switch result{
            case.success(let value):
                self.dataResponse = value
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    }
    
    
    
    func getAccessories() {
        
        let masks         = "Mask"
        let caps          = "Cap"
        let beanie        = "Beanie"
        let tote          = "Tote"
        let path          =  dataResponse.results[0].title
        let quantityPath  =  dataResponse.results[0].quantity
        
        //                    caps
        
        
        
        if path.contains(caps){
            print("This is a cap purchase")
            // set value for ui and database, also set value for masks bag and such
            
        }
        
        //                    masks
        
        if path.contains(masks) {
            print("This is a mask purchase")
            
        }
        
        //                    beanie
        
        if path.contains(beanie) {
            print("This is a beanie purchase")
            
        }
        
        //                    tote
        
        if path.contains(tote) {
            print("This is a tote purchase")
            
        }
    }
    
    
    
    
    
    
    func getTshirts() {
        
        
        let white             = "White"
        let black             = "Black"
        let longSleeveLarge   = "Long Sleeve - Large"
        let longSleeveMedium  = "Long Sleeve - Medium"
        let longSleeveSmall   = "Long Sleeve - Small"
        let shortSleeveSmall  = "Short Sleeve - Small"
        let shortSleeveMedium = "Short Sleeve -Medium"
        let shortSleeveLarge  = "Short Sleeve - Large"
        
        guard let sizePath    = dataResponse.results[0].variations[0].formattedValue else {return}
        guard let colourPath  = dataResponse.results[0].variations[1].formattedValue else {return}
        let quantityPath      = dataResponse.results[0].quantity
        let pricePath         = dataResponse.results[0].price
        let recieptPath       = dataResponse.results[0].receiptId
            
            
            //                    shortSleeveBlackSmall
        if sizePath.contains(shortSleeveSmall) && colourPath.contains(black) {
                print("This shirt is a shortSleeveSmall black")
                
                // Update ui and database and set things such as labels and bags value here too
                //            label.count  = label.count - quantityPath
                // use the reciept ID to check if the order isnt the same and do the function
            }
            
            //                    shortSleeveBlackMedium
            if sizePath.contains(shortSleeveMedium) && colourPath.contains(black)  {
                print("This shirt is a shortSleeveMedium")
            }
            
            //                    shortSleeveBlackLarge
            if sizePath.contains(shortSleeveLarge) && colourPath.contains(black) {
                print("This shirt is a shortSleeveLarge black")
                
            }
            
            //                    shortSleeveWhiteSmall
            if sizePath.contains(shortSleeveSmall) && colourPath.contains(white) {
                print("This shirt is a shortSleeveSmall white")
                
            }
            //                    shortSleeveWhiteMedium
            if sizePath.contains(shortSleeveMedium) && colourPath.contains(white) {
                print("This shirt is a shortSleeveMedium white")
                
            }
            //                    shortSleeveWhiteLarge
            if sizePath.contains(shortSleeveLarge) && colourPath.contains(white) {
                print("This shirt is a shortSleeveLarge white")
                
            }
            
            //                    longSleeveBlackSmall
            if sizePath.contains(longSleeveSmall) && colourPath.contains(black) {
                print("This shirt is a longSleeveSmall black")
                
                
            }
            
            //                    longSleeveBlackMedium
            if sizePath.contains(longSleeveMedium) && colourPath.contains(black) {
                print("This shirt is a longSleeveMedium black")
                
            }
            //                    longSleeveBlackLarge
            if sizePath.contains(longSleeveLarge) && colourPath.contains(black) {
                print("This shirt is a longSleeveLarge black")
                
            }
            
            
            //                    longSleeveWhiteSmall
            if sizePath.contains(longSleeveSmall) && colourPath.contains(white) {
                print("This shirt is a longSleeveSmall white")
                
            }
            //                    longSleeveWhiteMedium
            if sizePath.contains(longSleeveMedium) && colourPath.contains(white) {
                print("This shirt is a longSleeveMedium white")
                
            }
            //                    longSleeveWhiteLarge
            if sizePath.contains(longSleeveLarge) && colourPath.contains(white) {
                print("This shirt is a longSleeveLarge white")
                
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
}

//    func getTshirts(itemInfoType:itemInfoType) {
//
//        NetworkManager.shared.testRequestOne { (result) in
//            switch result{
//            case.success(let value):
//
//                //                    shortSleeveBlackSmall
//                if value.results[0].variations[0].formattedValue.contains("short Sleeve") && value.results[0].variations[1].formattedValue.contains("black") {
//                    print("TRUE")
//                }
//                //                    shortSleeveBlackMedium
//                if value.results[0].variations[0].formattedValue.contains("short Sleeve") && value.results[0].variations[1].formattedValue.contains("black") {
//                    print("TRUE")
//                }
//                //                    shortSleeveBlackLarge
//                if value.results[0].variations[0].formattedValue.contains("short Sleeve") && value.results[0].variations[1].formattedValue.contains("black") {
//                    print("TRUE")
//                }
//                //                    shortSleeveWhiteSmall
//                if value.results[0].variations[0].formattedValue.contains("short Sleeve") && value.results[0].variations[1].formattedValue.contains("black") {
//                    print("TRUE")
//                }
//                //                    shortSleeveWhiteMedium
//                if value.results[0].variations[0].formattedValue.contains("short Sleeve") && value.results[0].variations[1].formattedValue.contains("black") {
//                    print("TRUE")
//                }
//                //                    shortSleeveWhiteLarge
//                if value.results[0].variations[0].formattedValue.contains("short Sleeve") && value.results[0].variations[1].formattedValue.contains("black") {
//                    print("TRUE")
//                }
//
//                //                    longSleeveBlackSmall
//                if value.results[0].variations[0].formattedValue.contains("Long Sleeve") && value.results[0].variations[1].formattedValue.contains("black") {
//                    print("TRUE")
//                }
//                //                    longSleeveBlackMedium
//                if value.results[0].variations[0].formattedValue.contains("Long Sleeve") && value.results[0].variations[1].formattedValue.contains("black") {
//                    print("TRUE")
//
//                }
//
//                //                    longSleeveBlackLarge
//                if value.results[0].variations[0].formattedValue.contains("Long Sleeve") && value.results[0].variations[1].formattedValue.contains("black") {
//                    print("TRUE")
//                }
//
//                //                    longSleeveWhiteSmall
//                if value.results[0].variations[0].formattedValue.contains("Long Sleeve") && value.results[0].variations[1].formattedValue.contains("black") {
//                    print("TRUE")
//                }
//
//                //                    longSleeveWhiteMedium
//                if value.results[0].variations[0].formattedValue.contains("Long Sleeve") && value.results[0].variations[1].formattedValue.contains("black") {
//                    print("TRUE")
//
//                }
//                //                    longSleeveWhiteLarge
//                if value.results[0].variations[0].formattedValue.contains("Long Sleeve") && value.results[0].variations[1].formattedValue.contains("black") {
//                    print("TRUE")
//
//                }
//            case .failure(let failure):
//                print(failure.localizedDescription)
//
//            }
//
//
//
//        }
//
//
//
//    }


//func dismissKeyboard(){
//    let tap = UITapGestureRecognizer(target: self.view, action:#selector(UIView.endEditing(_:)))
//    tap.cancelsTouchesInView = false
//    view.addGestureRecognizer(tap)
//}
//
//}



//func getTshirts(itemInfoType:itemInfoType) {
//
//    switch itemInfoType {
//
//    case .shortSleeveBlackSmall:
//        if dataResponse.results[0].variations[0].formattedValue.contains("short Sleeve") && dataResponse.results[0].variations[1].formattedValue.contains("black") {
//            print("TRUE")
//            // set reduction in database of stock value and UI
//        }
//    case .shortSleeveBlackMedium:
//        if dataResponse.results[0].variations[0].formattedValue.contains("short Sleeve") && dataResponse.results[0].variations[1].formattedValue.contains("black") {
//            print("TRUE")
//
//            // set reduction in database of stock value and UI
//        }
//    case .shortSleeveBlackLarge:
//        if dataResponse.results[0].variations[0].formattedValue.contains("short Sleeve") && dataResponse.results[0].variations[1].formattedValue.contains("black") {
//            print("TRUE")
//
//            // set reduction in database of stock value and UI
//        }
//    case .shortSleeveWhiteSmall:
//        if dataResponse.results[0].variations[0].formattedValue.contains("short Sleeve") && dataResponse.results[0].variations[1].formattedValue.contains("black") {
//            print("TRUE")
//
//            // set reduction in database of stock value and UI
//        }
//    case .shortSleeveWhiteMedium:
//        if dataResponse.results[0].variations[0].formattedValue.contains("short Sleeve") && dataResponse.results[0].variations[1].formattedValue.contains("black") {
//            print("TRUE")
//
//            // set reduction in database of stock value and UI
//        }
//    case .shortSleeveWhiteLarge:
//        if dataResponse.results[0].variations[0].formattedValue.contains("short Sleeve") && dataResponse.results[0].variations[1].formattedValue.contains("black") {
//            print("TRUE")
//
//            // set reduction in database of stock value and UI
//        }
//    case .longSleeveBlackSmall:
//        if dataResponse.results[0].variations[0].formattedValue.contains("Long Sleeve") && dataResponse.results[0].variations[1].formattedValue.contains("black") {
//            print("TRUE")
//
//            // set reduction in database of stock value and UI
//        }
//    case .longSleeveBlackMedium:
//        if dataResponse.results[0].variations[0].formattedValue.contains("Long Sleeve") && dataResponse.results[0].variations[1].formattedValue.contains("black") {
//            print("TRUE")
//
//            // set reduction in database of stock value and UI
//        }
//    case .longSleeveBlackLarge:
//        if dataResponse.results[0].variations[0].formattedValue.contains("Long Sleeve") && dataResponse.results[0].variations[1].formattedValue.contains("black") {
//            print("TRUE")
//
//            // set reduction in database of stock value and UI
//        }
//
//    case .longSleeveWhiteSmall:
//        if dataResponse.results[0].variations[0].formattedValue.contains("Long Sleeve") && dataResponse.results[0].variations[1].formattedValue.contains("black") {
//            print("TRUE")
//
//            // set reduction in database of stock value and UI
//        }
//    case .longSleeveWhiteMedium:
//        if dataResponse.results[0].variations[0].formattedValue.contains("Long Sleeve") && dataResponse.results[0].variations[1].formattedValue.contains("black") {
//            print("TRUE")
//
//            // set reduction in database of stock value and UI
//        }
//    case .longSleeveWhiteLarge:
//        if dataResponse.results[0].variations[0].formattedValue.contains("Long Sleeve") && dataResponse.results[0].variations[1].formattedValue.contains("black") {
//            print("TRUE")
//
//            // set reduction in database of stock value and UI
//        }
//    }
//
//
//
//}
//
