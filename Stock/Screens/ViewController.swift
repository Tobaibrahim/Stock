//
//  ViewController.swift
//  Stock
//
//  Created by TXB4 on 24/08/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit
import OAuthSwift

class ViewController: UIViewController {
    
    
    
    //MARK: - Properties

    
    var responseURL     = String()
    var authToken       = String()
    var authTokenSecret = String()
    var randomArray     = ["one"]
    
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
        dismissKeyboard()
        NetworkManager.shared.testRequestOne { (result) in
            switch result{
            case.success(let value):
                print(value.results[0].price)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
            
        }
      
    }
    
    
    func configureUI() {
        view.backgroundColor = .systemGray2
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(connectButton)
        
        
        textField.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 100)
        button.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 300)
        connectButton.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 500)
        
        button.addTarget(self, action:  #selector(connectToEtsy), for: .touchUpInside)
        connectButton.addTarget(self, action: #selector(authoriseEtsy), for: .touchUpInside)
    }
    
    
    
    @objc func connectToEtsy() {
        guard let url = URL(string:responseURL) else {return}
        presentSafariVC(with: url)
    }
    
    
    
    @objc func authoriseEtsy() {

        guard let text  = textField.text   else {return}
        print(text)
        
        
    }
    
    
    
    func dismissKeyboard(){
           let tap = UITapGestureRecognizer(target: self.view, action:#selector(UIView.endEditing(_:)))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
       }

}
