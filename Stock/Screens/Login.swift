//
//  Login.swift
//  Stock
//
//  Created by TXB4 on 09/09/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//

import UIKit
import Firebase


class Login:UIViewController {
    
    //MARK: - Properties
    let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "StockLogo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let loginButton = Button(backgroundColour: Colours.loginButton, title: "LOGIN")
    let usernameTextField = TextField(placeholderText: "Username", passwordEntry: false, borderColour: Colours.appWhite.cgColor, textColour: Colours.appWhite)
    let passwordTextField = TextField(placeholderText: "Password", passwordEntry: true, borderColour: Colours.appWhite.cgColor, textColour: Colours.appWhite)
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    //MARK: - Helpers
    
    func configureUI() {
        createDismissKeyboardTapGseture()
        view.backgroundColor = Colours.loginBackground
        navigationController?.navigationBar.isHidden = true
        let viewComponents = [logoImage,passwordTextField,usernameTextField,loginButton]
        for views in viewComponents {
            view.addSubview(views)
        }
        
        logoImage.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 168)
        logoImage.setDimensions(width: 211, height: 84)
        usernameTextField.centerX(inView: view, topAnchor: logoImage.bottomAnchor, paddingTop: 89)
        usernameTextField.setDimensions(width: 314, height: 61)
        passwordTextField.centerX(inView: view, topAnchor: usernameTextField.bottomAnchor, paddingTop: 42)
        passwordTextField.setDimensions(width: 314, height: 61)
        loginButton.centerX(inView: view, topAnchor: passwordTextField.bottomAnchor, paddingTop: 43)
        loginButton.setDimensions(width: 314, height: 61)
        loginButton.addTarget(self, action: #selector(pushLogin), for: .touchUpInside)
    }
    
    
    @objc func pushLogin () {
        
        
        
        if (usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty) {
            CustomAlertOnMainThread(title: "Missing Information", message: "Please fill in all the fields so you can login.😁", buttonTitle: "Okay")
        }
        
        
        guard let username    = usernameTextField.text else {return}
        guard let password    = passwordTextField.text else {return}
        
        AuthService.shared.logUserIn(withEmail: username, password: password) { (result, error) in
            
            if let error = error {
                if error.localizedDescription.contains("Too many unsuccessful login attempts. Please try again later.") {
                    self.CustomAlertOnMainThread(title: "Unable to login", message: "Too many failed login attempts please try again later", buttonTitle: "Okay ☹️")
                }
                print("DEBUG: Error \(error.localizedDescription)")
                self.CustomAlertOnMainThread(title: "Unable to login", message: "The password or username is incorrect please try again", buttonTitle: "Okay ☹️")
                print("DEBUG: User successfully logged in")
                
            }
                
            else {
                
                guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {
                    return
                }
                
                guard let tab = window.rootViewController as? MainNavigationController else {return}
                
                tab.authenticateUserAndConfigureUI()
                // we access the mainttabbarcontroller and run the function here
                
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
    
    
    
    func createDismissKeyboardTapGseture() {
        let tap = UITapGestureRecognizer(target: self.view, action:#selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        // added a tap gesture to dismiss the keyboard - self.view means we are refering to this view, when tapped the keyboard will dismiss
    }
}



extension Login: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}
