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
            print(stockDataResponse!)
        }
        
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
    let shirtImages  = ["blacktshirt","whitetshirt","longsleeveblackshirt","longsleevewhiteshirt","beanie","hat","mask","totebag","Postage Bag",
                        "Mask Postage Bag","Clear Bag","Customs Form","Customs Form Tracked","Thermal Labels"]
    
    let shirtNames   = ["Short Sleeve - Black","Short Sleeve - White","Long Sleeve - Black","Long Sleeve - White","Beanie","Cap","Mask","Totebag",
                        "Postage Bag","Mask Postage Bag","Clear Bag","Customs Form","Customs Form Tracked","Thermal Labels"
        
    ]
    let coloursArray  = [Colours.lime,Colours.loginBackground,Colours.loginButton,Colours.orange,Colours.peach,Colours.pink,Colours.teal,Colours.yellow]
    var stockNameArrayKeys = [String]()
    
    
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
        createObservers()
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
        UserService.shared.fetchStockQuantity { (result,keys)  in
            self.stockDataResponse = result
            self.stockNameArrayKeys = keys
        }
    }
    
    func convertShirtValues(completed:([Int],[Int],[Int],[Int]) -> Void) {
        let longSleeveBlack  = stockDataResponse.LongSleeveBlack.map{$0.value}.sorted()
        let longSleeveWhite  = stockDataResponse.LongSleeveWhite.map{$0.value}.sorted()
        let shortSleeveWhite = stockDataResponse.ShortSleeveWhite.map{$0.value}.sorted()
        let shortSleeveBlack = stockDataResponse.ShortSleeveBlack.map{$0.value}.sorted()
        
        completed(longSleeveBlack,longSleeveWhite,shortSleeveWhite,shortSleeveBlack)
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
    
    
    func createObservers() {
        let name = NSNotification.Name(notificationKeys.reloadCollectionView)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: name, object: nil)
    }
    
    @objc func reloadCollectionView() {
        getStocks()        
    }
    
    
}


extension Stocks:UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  shirtNames.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: StockCell.reuseID, for: indexPath) as! StockCell
        
        cell.contentView.backgroundColor = coloursArray.randomElement()
        cell.avatarImageView.image = UIImage(named: shirtImages[indexPath.row])
        cell.titleLabel.text  = shirtNames[indexPath.row]
        cell.smallLabel.text  = "S"
        cell.mediumLabel.text = "M"
        cell.LargeLabel.text  = "L"
        
        //        longSleeveBlack,longSleeveWhite,shortSleeveWhite,shortSleeveBlack
        
        convertShirtValues { (longSleeveBlack, longSleeveWhite, shortSleeveWhite, shortSleeveBlack) in
            switch indexPath.row {
            case 0:
                //ShortSleeveBlack
                cell.smallLabelValue.text = String(shortSleeveBlack[1])
                cell.mediumLabelValue.text = String(shortSleeveBlack[2])
                cell.LargeLabelValue.text  = String(shortSleeveBlack[0])
                
            case 1:
                //ShortSleeveWhite
                cell.smallLabelValue.text = String(shortSleeveWhite[1])
                cell.mediumLabelValue.text = String(shortSleeveWhite[2])
                cell.LargeLabelValue.text  = String(shortSleeveWhite[0])
            case 2:
                //LongSleeveBlack
                cell.smallLabelValue.text = String(longSleeveBlack[1])
                cell.mediumLabelValue.text = String(longSleeveBlack[2])
                cell.LargeLabelValue.text  = String(longSleeveBlack[0])
                
            case 3:
                
                //LongSleeveWhite
                cell.smallLabelValue.text = String(longSleeveWhite[1])
                cell.mediumLabelValue.text = String(longSleeveWhite[2])
                cell.LargeLabelValue.text  = String(longSleeveWhite[0])
                
                
            case 4:
                
                //Beanie
                cell.mediumLabelValue.text = String(stockDataResponse.Beanie)
                break
                
                
            case 5:
                
                //Cap
                cell.mediumLabelValue.text = String(stockDataResponse.Cap)
                
            case 6:
                
                //Mask
                cell.mediumLabelValue.text = String(stockDataResponse.Mask)
                
            case 7:
                
                //Tote
                cell.mediumLabelValue.text = String(stockDataResponse.Tote)
                
                
                
            case 8:
                //PostageBag
                cell.mediumLabelValue.text = String(stockDataResponse.PostalBag)

                
                
            case 9:
                //MaskPostageBag
                cell.mediumLabelValue.text = String(stockDataResponse.MaskPostalBag)

                
                
            case 10:
                //ClearBag
                cell.mediumLabelValue.text = String(stockDataResponse.ClearBag)

                
            case 11:
                //CustomsForm
                cell.mediumLabelValue.text = String(stockDataResponse.CustomsForm)

                
            case 12:
                //CustomsFormTracked
                cell.mediumLabelValue.text = String(stockDataResponse.CustomsFormTracked)

                
                
            case 13:
                //ThermalLabel
                cell.mediumLabelValue.text = String(stockDataResponse.ThermalLabel)

                
            default:
                break
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imageNamePath = shirtImages[indexPath.row]
        let shirtNamePath = shirtNames[indexPath.row]
        let destVC  = EditStocks()
        destVC.backgroundColour = coloursArray.randomElement()
        destVC.itemImageName    = imageNamePath
        destVC.itemName         = shirtNamePath // The item name for the text value
        
        convertShirtValues { (longSleeveBlack, longSleeveWhite, shortSleeveWhite, shortSleeveBlack) in
            // using the return values for the tshirts we pass the s,m,l labels to the databse values, I did this because we had to parse the dictionary data
            switch indexPath.row {
            case 0:
                // ShortSleeveBlack
                destVC.itemPathName     = stockNameArrayKeys[0]
                destVC.smallLabelValue  = shortSleeveBlack[1]
                destVC.mediumLabelValue = shortSleeveBlack[2]
                destVC.largeLabelValue  = shortSleeveBlack[0]
            case 1:
                // ShortSleeveWhite
                destVC.itemPathName     = stockNameArrayKeys[2]
                destVC.smallLabelValue  = shortSleeveWhite[1]
                destVC.mediumLabelValue = shortSleeveWhite[2]
                destVC.largeLabelValue  = shortSleeveWhite[0]
            case 2:
                //LongSleeveBlack
                destVC.itemPathName     = stockNameArrayKeys[7]
                destVC.smallLabelValue  = longSleeveBlack[1]
                destVC.mediumLabelValue = longSleeveBlack[2]
                destVC.largeLabelValue  = longSleeveBlack[0]
            case 3:
                //LongSleeveWhite
                destVC.itemPathName     = stockNameArrayKeys[3]
                destVC.smallLabelValue  = longSleeveWhite[1]
                destVC.mediumLabelValue = longSleeveWhite[2]
                destVC.largeLabelValue  = longSleeveWhite[0]
            case 4:
                //Beanie
                destVC.itemPathName     = stockNameArrayKeys[9]
                destVC.smallLabelValue  = stockDataResponse.Beanie
                destVC.isAccessory      = true
                
            case 5:
                //Cap
                destVC.itemPathName     = stockNameArrayKeys[4]
                destVC.smallLabelValue  = stockDataResponse.Cap // using the response data to add the default value to the edit view
                destVC.isAccessory      = true
            case 6:
                //Mask
                destVC.itemPathName     = stockNameArrayKeys[1]
                destVC.smallLabelValue  = stockDataResponse.Mask
                destVC.isAccessory      = true
            case 7:
                //Tote
                destVC.itemPathName     = stockNameArrayKeys[12]
                destVC.smallLabelValue  = stockDataResponse.Tote
                destVC.isAccessory      = true
                
                
            case 8:
                //PostageBag
                destVC.itemPathName     = stockNameArrayKeys[8]
                destVC.smallLabelValue  = stockDataResponse.PostalBag
                destVC.isAccessory      = true
                
                
            case 9:
                //MaskPostageBag
                destVC.itemPathName     = stockNameArrayKeys[5]
                destVC.smallLabelValue  = stockDataResponse.MaskPostalBag
                destVC.isAccessory      = true
                
                
            case 10:
                //ClearBag
                destVC.itemPathName     = stockNameArrayKeys[13]
                destVC.smallLabelValue  = stockDataResponse.ClearBag
                destVC.isAccessory      = true
                
            case 11:
                //CustomsForm
                destVC.itemPathName     = stockNameArrayKeys[11]
                destVC.smallLabelValue  = stockDataResponse.CustomsForm
                destVC.isAccessory      = true
                
                
            case 12:
                //CustomsFormTracked
                destVC.itemPathName     = stockNameArrayKeys[5]
                destVC.smallLabelValue  = stockDataResponse.CustomsFormTracked
                destVC.isAccessory      = true
                
                
            case 13:
                //ThermalLabel
                destVC.itemPathName     = stockNameArrayKeys[10]
                destVC.smallLabelValue  = stockDataResponse.ThermalLabel
                destVC.isAccessory      = true
                
            default:
                break
            }
            
            
            
            
        }
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



