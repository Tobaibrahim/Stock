//
//  Stocks.swift
//  Stock
//
//  Created by TXB4 on 09/09/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//


import UIKit
import Firebase


class Stocks:UIViewController, UICollectionViewDataSource {
    
    
    //MARK: - Properties
    
    
    var dataResponse: ShopTransactionsResponse! {
        didSet {
            print("DATA SET")
            updateStocks()
        }
        
    }
    
    var stockDataResponse: StockQuantityViewModel! {
        didSet {
            print("DATA SET")
            //            updateStocks() // timing issue index crash
            collectionView.dataSource = self
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
    var recieptID = Int()
    var stockNameArrayKeys = [String]()
    let localTransactionValues = UserDefaults.standard
    lazy var requestTransactionValues = [Int]()
    
  
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStocks()
        getData()
        configureUI()
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
            self.stockDataResponse  = StockQuantityViewModel.init(stockQuantity: result)
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
        //        let testValues = [2086242144, 2086132435, 2085323826, 2083046433, 2082421374, 2082200963, 2082178144, 2081572867, 2081504156, 2081281589, 2080812449, 2079165911]
        guard let safeResponse   = dataResponse.map({$0.results[0...11].map{$0.transactionId}}) else {return} // get transaction value from request
        requestTransactionValues = safeResponse // get transaction value from request
        let name = "localTransactionValue"
        let localTransVal = localTransactionValues.object(forKey: name) as! [Int]
        let difference    = requestTransactionValues.difference(from:localTransVal).insertions // returns an array of values that are different in comparison
        var changedIndex  = [Int]() // value of index changes
        
        for values in difference { // we have to do this because the enums have the values wee need then we append the
            switch values {
            case.insert(let offset, _, _):
                changedIndex.append(offset)
            case .remove(offset:_ , element: _, associatedWith:_):
                break
            }
        }
        
        
        if requestTransactionValues == localTransVal  {
            print("DEBUG: VALUES ARE THE SAME")
            
        }
            
            
        else {
            print("DEBUG: VALUES CHANGED")
            completion(changedIndex)
            
            localTransactionValues.set(requestTransactionValues, forKey: name) // set new local value if values have changed
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
                    
                    func compress() {
                        UserService.shared.updateAccessoryStockQuantity(Name: "ClearBag", value: stockDataResponse.ClearBag - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "PostalBag", value: stockDataResponse.PostalBag - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "ThermalLabel", value: stockDataResponse.ThermalLabel - quantityPath)
                    }
                    
                    // create a way to authorize values
                    
                    let path              = dataResponse.results[values].title
                    guard let sizePath    = dataResponse.results[values].variations[safe:0]?.formattedValue else {return}   // fix the index crashing
                    guard let colourPath  = dataResponse.results[values].variations[safe:1]?.formattedValue else {return} // fix index crashing
                    let quantityPath      = dataResponse.results[values].quantity
                    let tagsPath          = dataResponse.results[values].tags
                 // let pricePath         = dataResponse.results[values].price
                    print("DEBUG: QUANTITY PATH  = \(quantityPath)")
                    
                    
                    //                    shortSleeveBlackSmall
                    if sizePath.contains(stockDataResponse.shortSleeveSmall) && colourPath.contains(stockDataResponse.black) {
                        print("This shirt is a shortSleeveSmall black")
                        UserService.shared.updateShirtStockQuantity(Name: "ShortSleeveBlack", small: shortSleeveBlack[1] - quantityPath, medium: shortSleeveBlack[2] , large: shortSleeveBlack[0])
                        compress()
                    }
                    
                    //                    shortSleeveBlackMedium
                    if sizePath.contains(stockDataResponse.shortSleeveMedium) && colourPath.contains(stockDataResponse.black) {
                        print("This shirt is a shortSleeveMedium")
                        UserService.shared.updateShirtStockQuantity(Name: "ShortSleeveBlack", small: shortSleeveBlack[1], medium: shortSleeveBlack[2] - quantityPath, large: shortSleeveBlack[0])
                        compress()
                        
                    }
                    
                    //                    shortSleeveBlackLarge
                    if sizePath.contains(stockDataResponse.shortSleeveLarge) && colourPath.contains(stockDataResponse.black) {
                        UserService.shared.updateShirtStockQuantity(Name: "ShortSleeveBlack", small: shortSleeveBlack[1], medium: shortSleeveBlack[2], large: shortSleeveBlack[0] - quantityPath)
                        compress()
                        print("This shirt is a shortSleeveLarge black")
                        
                    }
                    
                    //                    shortSleeveWhiteSmall
                    if sizePath.contains(stockDataResponse.shortSleeveSmall) && colourPath.contains(stockDataResponse.white) {
                        UserService.shared.updateShirtStockQuantity(Name: "ShortSleeveWhite", small: shortSleeveWhite[1] - quantityPath, medium: shortSleeveWhite[2], large: shortSleeveWhite[0])
                        compress()
                        print("This shirt is a shortSleeveSmall white")
                        
                    }
                    
                    //                    shortSleeveWhiteMedium
                    if sizePath.contains(stockDataResponse.shortSleeveMedium) && colourPath.contains(stockDataResponse.white) {
                        UserService.shared.updateShirtStockQuantity(Name: "ShortSleeveWhite", small: shortSleeveWhite[1] , medium: shortSleeveWhite[2] - quantityPath, large: shortSleeveWhite[0])
                        compress()
                        print("This shirt is a shortSleeveMedium white")
                        
                    }
                    
                    //                    shortSleeveWhiteLarge
                    if sizePath.contains(stockDataResponse.shortSleeveLarge) && colourPath.contains(stockDataResponse.white) {
                        UserService.shared.updateShirtStockQuantity(Name: "ShortSleeveWhite", small: shortSleeveWhite[1] , medium: shortSleeveWhite[2] , large: shortSleeveWhite[0] - quantityPath)
                        compress()
                        print("This shirt is a shortSleeveLarge white")
                        
                    }
                    
                    //                    longSleeveBlackSmall
                    if sizePath.contains(stockDataResponse.longSleeveSmall) && colourPath.contains(stockDataResponse.black) {
                        UserService.shared.updateShirtStockQuantity(Name: "LongSleeveBlack", small: longSleeveBlack[1] - quantityPath , medium: longSleeveBlack[2] , large: longSleeveBlack[0])
                        compress()
                        print("This shirt is a longSleeveSmall black")
                    }
                    
                    //                    longSleeveBlackMedium
                    if sizePath.contains(stockDataResponse.longSleeveMedium) && colourPath.contains(stockDataResponse.black) {
                        UserService.shared.updateShirtStockQuantity(Name: "LongSleeveBlack", small: longSleeveBlack[1] , medium: longSleeveBlack[2] - quantityPath, large: longSleeveBlack[0])
                        compress()
                        print("This shirt is a longSleeveMedium black")
                    }
                    
                    //                    longSleeveBlackLarge
                    if sizePath.contains(stockDataResponse.longSleeveLarge) && colourPath.contains(stockDataResponse.black) {
                        UserService.shared.updateShirtStockQuantity(Name: "LongSleeveBlack", small: longSleeveBlack[1] , medium: longSleeveBlack[2] , large: longSleeveBlack[0] - quantityPath)
                        compress()
                        print("This shirt is a longSleeveLarge black")
                    }
                    
                    //                    longSleeveWhiteSmall
                    if sizePath.contains(stockDataResponse.longSleeveSmall) && colourPath.contains(stockDataResponse.white) {
                        UserService.shared.updateShirtStockQuantity(Name: "LongSleeveWhite", small: longSleeveWhite[1] - quantityPath, medium: longSleeveWhite[2] , large: longSleeveWhite[0])
                        compress()
                        print("This shirt is a longSleeveSmall white")
                    }
                    
                    //                    longSleeveWhiteMedium
                    if sizePath.contains(stockDataResponse.longSleeveMedium) && colourPath.contains(stockDataResponse.white) {
                        UserService.shared.updateShirtStockQuantity(Name: "LongSleeveWhite", small: longSleeveWhite[1], medium: longSleeveWhite[2] - quantityPath , large: longSleeveWhite[0])
                        compress()
                        print("This shirt is a longSleeveMedium white")
                    }
                    
                    //                    longSleeveWhiteLarge
                    if sizePath.contains(stockDataResponse.longSleeveLarge) && colourPath.contains(stockDataResponse.white) {
                        UserService.shared.updateShirtStockQuantity(Name: "LongSleeveWhite", small: longSleeveWhite[1], medium: longSleeveWhite[2], large: longSleeveWhite[0] - quantityPath )
                        compress()
                        print("This shirt is a longSleeveLarge white")
                    }
                    
                    //                    caps
                    if path.contains(stockDataResponse.caps) || tagsPath.contains(stockDataResponse.caps){
                        UserService.shared.updateAccessoryStockQuantity(Name: "Cap", value: stockDataResponse.Cap - quantityPath)
                        compress()
                        print("This is a cap purchase")
                        // set value for ui and database, also set value for masks bag and such
                    }
                    
                    
                    //                    masks
                    if path.contains(stockDataResponse.masks) || tagsPath.contains(stockDataResponse.masks) {
                        print("This is a mask purchase")
                        UserService.shared.updateAccessoryStockQuantity(Name: "Mask", value: stockDataResponse.Mask - quantityPath)
                        UserService.shared.updateAccessoryStockQuantity(Name: "Mask", value: stockDataResponse.MaskPostalBag - quantityPath)
                    }
                    
                    //                    beanie
                    
                    if path.contains(stockDataResponse.beanie) || tagsPath.contains(stockDataResponse.beanie) {
                        UserService.shared.updateAccessoryStockQuantity(Name: "Beanie", value: stockDataResponse.Beanie - quantityPath)
                        compress()
                        print("This is a beanie purchase")
                        
                    }
                    
                    //                    tote
                    
                    if path.contains(stockDataResponse.tote) || tagsPath.contains(stockDataResponse.tote) {
                        UserService.shared.updateAccessoryStockQuantity(Name: "Tote", value: stockDataResponse.Tote - quantityPath)
                        compress()
                        print("This is a tote purchase")
                    }
                    
                }
                
            }
            
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY       = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height + 200
        let height        = scrollView.frame.size.height + 200
        // the height of our screen
        
        if offsetY > contentHeight - height + 100 {
            getStocks()
            getData()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
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

extension Stocks: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
}







