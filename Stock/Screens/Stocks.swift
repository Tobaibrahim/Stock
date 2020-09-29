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
            collectionView.dataSource = self
            collectionView.reloadData()
            updateStocks()
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
    var isAccessory   = false
    var recieptID = Int()
    var stockNameArrayKeys = [String]()
    let localTransactionValues = UserDefaults.standard
    var requestTransactionValues = [Int]()
    
    
    let shirtImages       = ["blacktshirt","whitetshirt","longsleeveblackshirt","longsleevewhiteshirt","beanie","hat","mask","totebag","Postage Bag","Mask Postage Bag","Clear Bag","Customs Form","Customs Form Tracked","Thermal Labels"]
    
    let shirtNames        = ["Short Sleeve - Black","Short Sleeve - White","Long Sleeve - Black","Long Sleeve - White","Beanie","Cap","Mask","Totebag","Postage Bag","Mask Postage Bag","Clear Bag","Customs Form","Customs Form Tracked","Thermal Labels"]
    
    let masks             = "mask"
    let caps              = "cap"
    let beanie            = "beanie"
    let tote              = "tote"
    
    let white             = "White"
    let black             = "Black"
    let longSleeveLarge   = "Long Sleeve - Large"
    let longSleeveMedium  = "Long Sleeve - Medium"
    let longSleeveSmall   = "Long Sleeve - Small"
    let shortSleeveSmall  = "Short Sleeve - Small"
    let shortSleeveMedium = "Short Sleeve -Medium"
    let shortSleeveLarge  = "Short Sleeve - Large"
    
    let coloursArray  = [Colours.lime,Colours.loginBackground,Colours.loginButton,Colours.orange,Colours.peach,Colours.pink,Colours.teal,Colours.yellow]
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getStocks()
        getData()
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
        
        let menuButton          = UIBarButtonItem(image: SFSymbols.menuButton, style: .done, target: self, action:#selector(Logout))
        menuButton.tintColor    = Colours.loginButton
        navigationItem.leftBarButtonItem  = menuButton
        collectionView.delegate   = self
        
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
    
    
    
    func authorizeSale(completion:([Int]) -> Void){
        let testValues = [2086242144, 2086132435, 2085323826, 2083046433, 2082421374, 2082200963, 2082178144, 2081572867, 2081504156, 2081281589, 2080812449, 2079165911]
        
        let testValues2 = [2083046626, 2082421317, 2082200883, 2082178190, 2081572356, 2081504166, 2081281589, 2080812449, 2079165911, 2079046333, 2078918037, 2078234545]
        
        guard let safeResponse   = dataResponse.map({$0.results[0...11].map{$0.transactionId}}) else {return} // get transaction value from request
        requestTransactionValues = safeResponse // get transaction value from request
        let name = "localTransactionValue"
        let localTransVal = localTransactionValues.object(forKey: name) as! [Int]
        let difference    = testValues2.difference(from:localTransVal).insertions // returns an array of values that are different in comparison
        var changedIndex  = [Int]() // value of index changes
        
        
        for values in difference { // we have to do this because the enums have the values wee need then we append the
            switch values {
            case.insert(let offset, _, _):
                changedIndex.append(offset)
            case .remove(offset:_ , element: _, associatedWith:_):
                break
            }
        }
        
        
        if testValues2 == localTransVal  {
            print("DEBUG: VALUES ARE THE SAME")
            
        }
            
            
        else {
            print("DEBUG: VALUES CHANGED")
            localTransactionValues.set(testValues2, forKey: name) // set new local value if values have changed
        }
        print("DEBUG: REQUEST TRANS VALUE = \(requestTransactionValues)")
        print("DEBUG: LOCAL TRANS VALUE   = \(localTransactionValues.object(forKey: name)!)")
        print("DEBUG: CHANGEDINDEX        = \(changedIndex)")
        
        completion(changedIndex)
        
    }
    
    
    func updateStocks() {
        convertShirtValues { (longSleeveBlack, longSleeveWhite, shortSleeveWhite, shortSleeveBlack) in
            authorizeSale { (index) in
                
                for values in index {
                    print("DEBUG: CHANGED VALUE = \(values)")
                    
                    // create a way to authorize values
                    
                    let path              = dataResponse.results[values].title
                    guard let sizePath    = dataResponse.results[values].variations[safe:0]?.formattedValue else {return}   // fix the index crashing
                    guard let colourPath  = dataResponse.results[values].variations[safe:1]?.formattedValue else {return} // fix index crashing
                    let quantityPath      = dataResponse.results[values].quantity
                    let tagsPath          = dataResponse.results[values].tags
                    //                let pricePath         = dataResponse.results[values].price
                    print("DEBUG: QUANTITY PATH  = \(quantityPath)")
                    
                    
                    //                    shortSleeveBlackSmall
                    if sizePath.contains(shortSleeveSmall) && colourPath.contains(black) {
                        print("This shirt is a shortSleeveSmall black")
                        //                    1 2 0
                        //                    small,medium,large
                        
                    }
                    
                    //                    shortSleeveBlackMedium
                    if sizePath.contains(shortSleeveMedium) && colourPath.contains(black) {
                        print("This shirt is a shortSleeveMedium")
                        UserService.shared.updateShirtStockQuantity(Name: "shortSleeveBlackMedium", small: shortSleeveBlack[1], medium: shortSleeveBlack[2] - quantityPath, large: shortSleeveBlack[0])
                        UserService.shared.updateAccessoryStockQuantity(Name: "ClearBag", value: stockDataResponse.ClearBag - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "PostalBag", value: stockDataResponse.PostalBag - quantityPath)
                        
                    }
                    
                    //                    shortSleeveBlackLarge
                    if sizePath.contains(shortSleeveLarge) && colourPath.contains(black) {
                        UserService.shared.updateShirtStockQuantity(Name: "shortSleeveBlackLarge", small: shortSleeveBlack[1], medium: shortSleeveBlack[2], large: shortSleeveBlack[0] - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "ClearBag", value: stockDataResponse.ClearBag - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "PostalBag", value: stockDataResponse.PostalBag - quantityPath)
                        print("This shirt is a shortSleeveLarge black")
                        
                    }
                    
                    
                    //                    shortSleeveWhiteSmall
                    if sizePath.contains(shortSleeveSmall) && colourPath.contains(white) {
                        UserService.shared.updateShirtStockQuantity(Name: "shortSleeveWhiteSmall", small: shortSleeveWhite[1] - quantityPath, medium: shortSleeveWhite[2], large: shortSleeveWhite[0])
                        UserService.shared.updateAccessoryStockQuantity(Name: "ClearBag", value: stockDataResponse.ClearBag - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "PostalBag", value: stockDataResponse.PostalBag - quantityPath)
                        print("This shirt is a shortSleeveSmall white")
                        
                    }
                    
                    //                    shortSleeveWhiteMedium
                    if sizePath.contains(shortSleeveMedium) && colourPath.contains(white) {
                        UserService.shared.updateShirtStockQuantity(Name: "shortSleeveWhiteMedium", small: shortSleeveWhite[1] , medium: shortSleeveWhite[2] - quantityPath, large: shortSleeveWhite[0])
                        UserService.shared.updateAccessoryStockQuantity(Name: "ClearBag", value: stockDataResponse.ClearBag - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "PostalBag", value: stockDataResponse.PostalBag - quantityPath)
                        print("This shirt is a shortSleeveMedium white")
                        
                    }
                    
                    //                    shortSleeveWhiteLarge
                    if sizePath.contains(shortSleeveLarge) && colourPath.contains(white) {
                        UserService.shared.updateShirtStockQuantity(Name: "shortSleeveWhiteLarge", small: shortSleeveWhite[1] , medium: shortSleeveWhite[2] , large: shortSleeveWhite[0] - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "ClearBag", value: stockDataResponse.ClearBag - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "PostalBag", value: stockDataResponse.PostalBag - quantityPath)
                        print("This shirt is a shortSleeveLarge white")
                        
                    }
                    
                    
                    //                    longSleeveBlackSmall
                    if sizePath.contains(longSleeveSmall) && colourPath.contains(black) {
                        UserService.shared.updateShirtStockQuantity(Name: "longSleeveBlackSmall", small: longSleeveBlack[1] - quantityPath , medium: longSleeveBlack[2] , large: longSleeveBlack[0])
                        UserService.shared.updateAccessoryStockQuantity(Name: "ClearBag", value: stockDataResponse.ClearBag - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "PostalBag", value: stockDataResponse.PostalBag - quantityPath)
                        print("This shirt is a longSleeveSmall black")
                        
                        
                    }
                    
                    
                    //                    longSleeveBlackMedium
                    if sizePath.contains(longSleeveMedium) && colourPath.contains(black) {
                        UserService.shared.updateShirtStockQuantity(Name: "longSleeveBlackMedium", small: longSleeveBlack[1] , medium: longSleeveBlack[2] - quantityPath, large: longSleeveBlack[0])
                        UserService.shared.updateAccessoryStockQuantity(Name: "ClearBag", value: stockDataResponse.ClearBag - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "PostalBag", value: stockDataResponse.PostalBag - quantityPath)
                        print("This shirt is a longSleeveMedium black")
                        
                    }
                    
                    //                    longSleeveBlackLarge
                    if sizePath.contains(longSleeveLarge) && colourPath.contains(black) {
                        UserService.shared.updateShirtStockQuantity(Name: "longSleeveBlackLarge", small: longSleeveBlack[1] , medium: longSleeveBlack[2] , large: longSleeveBlack[0] - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "ClearBag", value: stockDataResponse.ClearBag - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "PostalBag", value: stockDataResponse.PostalBag - quantityPath)
                        print("This shirt is a longSleeveLarge black")
                        
                    }
                    
                    //                    longSleeveWhiteSmall
                    if sizePath.contains(longSleeveSmall) && colourPath.contains(white) {
                        UserService.shared.updateShirtStockQuantity(Name: "longSleeveWhiteSmall", small: longSleeveWhite[1] - quantityPath, medium: longSleeveWhite[2] , large: longSleeveWhite[0])
                        UserService.shared.updateAccessoryStockQuantity(Name: "ClearBag", value: stockDataResponse.ClearBag - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "PostalBag", value: stockDataResponse.PostalBag - quantityPath)
                        print("This shirt is a longSleeveSmall white")
                        
                    }
                    
                    //                    longSleeveWhiteMedium
                    if sizePath.contains(longSleeveMedium) && colourPath.contains(white) {
                        UserService.shared.updateShirtStockQuantity(Name: "longSleeveWhiteSmall", small: longSleeveWhite[1], medium: longSleeveWhite[2] - quantityPath , large: longSleeveWhite[0])
                        UserService.shared.updateAccessoryStockQuantity(Name: "ClearBag", value: stockDataResponse.ClearBag - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "PostalBag", value: stockDataResponse.PostalBag - quantityPath)
                        print("This shirt is a longSleeveMedium white")
                        
                    }
                    
                    //                    longSleeveWhiteLarge
                    if sizePath.contains(longSleeveLarge) && colourPath.contains(white) {
                        UserService.shared.updateShirtStockQuantity(Name: "longSleeveWhiteSmall", small: longSleeveWhite[1], medium: longSleeveWhite[2], large: longSleeveWhite[0] - quantityPath )
                        UserService.shared.updateAccessoryStockQuantity(Name: "ClearBag", value: stockDataResponse.ClearBag - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "PostalBag", value: stockDataResponse.PostalBag - quantityPath)
                        print("This shirt is a longSleeveLarge white")
                        
                    }
                    
                    //                    caps
                    
                    if path.contains(caps) || tagsPath.contains(caps){
                        UserService.shared.updateAccessoryStockQuantity(Name: "Cap", value: stockDataResponse.Cap - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "ClearBag", value: stockDataResponse.ClearBag - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "PostalBag", value: stockDataResponse.PostalBag - quantityPath)
                        print("This is a cap purchase")
                        // set value for ui and database, also set value for masks bag and such
                        
                    }
                    
                    
                    //                    masks
                    if path.contains(masks) || tagsPath.contains(masks) {
                        print("This is a mask purchase")
                        UserService.shared.updateAccessoryStockQuantity(Name: "Mask", value: stockDataResponse.Mask - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "MaskPostalBag", value: stockDataResponse.MaskPostalBag - quantityPath)
                        
                        
                    }
                    
                    //                    beanie
                    
                    if path.contains(beanie) || tagsPath.contains(beanie) {
                        UserService.shared.updateAccessoryStockQuantity(Name: "Beanie", value: stockDataResponse.Beanie - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "ClearBag", value: stockDataResponse.ClearBag - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "PostalBag", value: stockDataResponse.PostalBag - quantityPath)
                        print("This is a beanie purchase")
                        
                    }
                    
                    
                    //                    tote
                    
                    if path.contains(tote) || tagsPath.contains(tote) {
                        UserService.shared.updateAccessoryStockQuantity(Name: "Tote", value: stockDataResponse.Tote - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "ClearBag", value: stockDataResponse.ClearBag - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "PostalBag", value: stockDataResponse.PostalBag - quantityPath)
                        print("This is a tote purchase")
                    }

                }
                
            }
            
        }
    }
    
    
    
    func createObservers() {
        let name = NSNotification.Name(notificationKeys.reloadCollectionView)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: name, object: nil)
    }
    
    @objc func reloadCollectionView() {
        getStocks()        
    }
    
    
    @objc func Logout() {
        
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {
            return
        }
        guard let tab = window.rootViewController as? MainNavigationController else {return}
        tab.logUserOut()
        // we access the mainttabbarcontroller and run the function here
        self.dismiss(animated: false, completion: nil)
        
        
    }
    
    func reload() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}


extension Stocks:UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return shirtNames.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sizes = ["S","M","L"]
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: StockCell.reuseID, for: indexPath) as! StockCell
        cell.contentView.backgroundColor = coloursArray.randomElement()
        
        cell.avatarImageView.image = UIImage(named: shirtImages[indexPath.row])
        cell.titleLabel.text  = shirtNames[indexPath.row]
        
        
        convertShirtValues { (longSleeveBlack, longSleeveWhite, shortSleeveWhite, shortSleeveBlack) in
            switch indexPath.row {
                
            case 0:
                //ShortSleeveBlack
                cell.smallLabelValue.text  = String(shortSleeveBlack[1])
                cell.mediumLabelValue.text = String(shortSleeveBlack[2])
                cell.LargeLabelValue.text  = String(shortSleeveBlack[0])
                cell.smallLabel.text  = sizes[0]
                cell.mediumLabel.text = sizes[1]
                cell.LargeLabel.text  = sizes[2]
                
            case 1:
                //ShortSleeveWhite
                cell.smallLabelValue.text  = String(shortSleeveWhite[1])
                cell.mediumLabelValue.text = String(shortSleeveWhite[2])
                cell.LargeLabelValue.text  = String(shortSleeveWhite[0])
                cell.smallLabel.text  = sizes[0]
                cell.mediumLabel.text = sizes[1]
                cell.LargeLabel.text  = sizes[2]
            case 2:
                //LongSleeveBlack
                cell.smallLabelValue.text  = String(longSleeveBlack[1])
                cell.mediumLabelValue.text = String(longSleeveBlack[2])
                cell.LargeLabelValue.text  = String(longSleeveBlack[0])
                cell.smallLabel.text  = sizes[0]
                cell.mediumLabel.text = sizes[1]
                cell.LargeLabel.text  = sizes[2]
                
            case 3:
                
                //LongSleeveWhite
                cell.smallLabelValue.text  = String(longSleeveWhite[1])
                cell.mediumLabelValue.text = String(longSleeveWhite[2])
                cell.LargeLabelValue.text  = String(longSleeveWhite[0])
                cell.smallLabel.text  = sizes[0]
                cell.mediumLabel.text = sizes[1]
                cell.LargeLabel.text  = sizes[2]
                
                
            case 4:
                //Beanie
                isAccessory = true
                cell.mediumLabelValue.text = String(stockDataResponse.Beanie)
                break
                
                
            case 5:
                //Cap
                isAccessory = true
                
                cell.mediumLabelValue.text = String(stockDataResponse.Cap)
                
            case 6:
                //Mask
                isAccessory = true
                cell.mediumLabelValue.text = String(stockDataResponse.Mask)
                
            case 7:
                //Tote
                isAccessory = true
                cell.mediumLabelValue.text = String(stockDataResponse.Tote)
                
            case 8:
                //PostageBag
                isAccessory = true
                cell.mediumLabelValue.text = String(stockDataResponse.PostalBag)
                
            case 9:
                //MaskPostageBag
                isAccessory = true
                cell.mediumLabelValue.text = String(stockDataResponse.MaskPostalBag)
                
            case 10:
                //ClearBag
                isAccessory = true
                cell.mediumLabelValue.text = String(stockDataResponse.ClearBag)
                
            case 11:
                //CustomsForm
                isAccessory = true
                cell.mediumLabelValue.text = String(stockDataResponse.CustomsForm)
                
            case 12:
                //CustomsFormTracked
                isAccessory = true
                cell.mediumLabelValue.text = String(stockDataResponse.CustomsFormTracked)
                
            case 13:
                //ThermalLabel
                isAccessory = true
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
                destVC.itemPathName     = stockNameArrayKeys[6]
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY       = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height + 200
        let height        = scrollView.frame.size.height + 200
        // the height of our screen
        
        if offsetY > contentHeight - height {
            updateStocks()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
           
        }
        
    
    }}



extension Stocks: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
}







