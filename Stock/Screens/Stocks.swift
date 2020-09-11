//
//  Stocks.swift
//  Stock
//
//  Created by TXB4 on 09/09/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//


import UIKit
import Firebase


class Stocks:UIViewController {
    
    //MARK: - Properties
    
    
    var dataResponse: ShopTransactionsResponse! {
        didSet {
            print("DATA SET")
        }
        
    }
    
    var stockDataResponse: StockQuantity! {
        didSet {
            print("DATA SET")
            collectionView.delegate   = self
            collectionView.dataSource = self
            collectionView.reloadData()
            let stockNameArray = String()
        }
        
    }
    
    
    enum itemInfoType {
        
        case shortSleeveBlackSmall,shortSleeveBlackMedium,shortSleeveBlackLarge,shortSleeveWhiteSmall,shortSleeveWhiteMedium,shortSleeveWhiteLarge,longSleeveBlackSmall,longSleeveBlackMedium,longSleeveBlackLarge,longSleeveWhiteSmall,longSleeveWhiteMedium,longSleeveWhiteLarge
    }
    
    
    let logOutButton            : Button = {
        let login = Button(backgroundColour: .systemRed, title: "LOGOUT")
        return login
    }()
    
    
    let searchBar:UISearchBar = {
        let searchBar         =  UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    var collectionView: UICollectionView!
    var isDifferentOrder:Bool!
    var recieptID = Int()
    let shirtImages  = ["blacktshirt","whitetshirt","longsleeveblackshirt","longsleevewhiteshirt","beanie","hat","mask","totebag"]
    let shirtNames   = ["Short Sleeve - Black","Short Sleeve - White","Long Sleeve - Black","Long Sleeve - White","Beanie","Hat","Mask","Totebag"]
    let coloursArray = [Colours.lime,Colours.loginBackground,Colours.loginButton,Colours.orange,Colours.peach,Colours.pink]
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getData()
        getStocks()
    }
    
    
    
    
    //MARK: - Helpers
    
    
    func configureUI() {
        
        view.addSubview(searchBar)
        
        view.backgroundColor   = Colours.appWhite
        navigationItem.hidesBackButton     = true
        
        let tap = UITapGestureRecognizer(target: self.view, action:#selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView  = false
        
        searchBar.delegate        = self
        navigationItem.titleView  = searchBar
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColomnFlowLayout(in:self.view ))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(StockCell.self, forCellWithReuseIdentifier:StockCell.reuseID)
        
        let menuButton          = UIBarButtonItem(image: SFSymbols.menuButton, style: .done, target: self, action:#selector(addButtonPressed))
        menuButton.tintColor    = Colours.loginButton
        navigationItem.leftBarButtonItem  = menuButton
    }
    

    
    @objc func addButtonPressed() {
        print("DEBUG:Menu button pressed")
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
       
    func getStocks() {
        UserService.shared.fetchStockQuantity { (result) in
            self.stockDataResponse = result
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
           
           print(pricePath)
           
               
               //                    shortSleeveBlackSmall
               if sizePath.contains(shortSleeveSmall) && colourPath.contains(black) {
                   print("This shirt is a shortSleeveSmall black")
                   
                   // Update ui and database and set things such as labels and bags value here too
                   //            label.count  = label.count - quantityPath
                   // use the reciept ID to check if the order isnt the same and do the function
               }
               
               //                    shortSleeveBlackMedium
               if sizePath.contains(shortSleeveMedium) && colourPath.contains(black) {
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


extension Stocks:UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: StockCell.reuseID, for: indexPath) as! StockCell
        cell.contentView.backgroundColor = coloursArray.randomElement()
        cell.avatarImageView.image = UIImage(named: shirtImages[indexPath.row])
        cell.titleLabel.text = shirtNames[indexPath.row]
        cell.smallLabel.text = "S"
        cell.mediumLabel.text = "M"
        cell.LargeLabel.text = "L"
        

        switch indexPath.row {
        case 0:
        cell.smallLabelValue.text  = String(stockDataResponse.shortSleeveBlackSmall)
        cell.mediumLabelValue.text = String(stockDataResponse.shortSleeveBlackMedium)
        cell.LargeLabelValue.text  = String(stockDataResponse.shortSleeveBlackLarge)
            
        case 1:
        cell.smallLabelValue.text  = String(stockDataResponse.shortSleeveBlackSmall)
        cell.mediumLabelValue.text = String(stockDataResponse.shortSleeveBlackMedium)
        cell.LargeLabelValue.text  = String(stockDataResponse.shortSleeveBlackLarge)
            
        case 2:
        cell.smallLabelValue.text  = String(stockDataResponse.shortSleeveBlackSmall)
        cell.mediumLabelValue.text = String(stockDataResponse.shortSleeveBlackMedium)
        cell.LargeLabelValue.text  = String(stockDataResponse.shortSleeveBlackLarge)
            
        case 3:
        cell.smallLabelValue.text  = String(stockDataResponse.shortSleeveBlackSmall)
        cell.mediumLabelValue.text = String(stockDataResponse.shortSleeveBlackMedium)
        cell.LargeLabelValue.text  = String(stockDataResponse.shortSleeveBlackLarge)
            
        
       case 4:
       cell.smallLabelValue.text  = String(stockDataResponse.shortSleeveBlackSmall)
       cell.mediumLabelValue.text = String(stockDataResponse.shortSleeveBlackMedium)
       cell.LargeLabelValue.text  = String(stockDataResponse.shortSleeveBlackLarge)
            
        default:
            break
        }


       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let shirtImages = ["blacktshirt","whitetshirt","longsleeveblackshirt","longsleevewhiteshirt","beanie","hat","mask","totebag"]
        let imageNamePath = shirtImages[indexPath.row]
        let shirtNamePath = shirtNames[indexPath.row]
        let destVC  = EditStocks()
        destVC.backgroundColour = coloursArray.randomElement()
        destVC.itemImageName    = imageNamePath
        destVC.itemName         = shirtNamePath
        
        
//        switch indexPath.row {
//        case 0:
//
//        case 1:
//
//
//        case 2:
//
//        case 3:
//
//        case 4:
//
//
//        case 5:
//
//
//        default:
//            break
//        }
        
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    
}



extension Stocks: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
}





//    @objc func Logout() {
//
//        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {
//            return
//        }
//        guard let tab = window.rootViewController as? MainNavigationController else {return}
//        tab.logUserOut()
//        // we access the mainttabbarcontroller and run the function here
//        self.dismiss(animated: false, completion: nil)
//
//
//    }



