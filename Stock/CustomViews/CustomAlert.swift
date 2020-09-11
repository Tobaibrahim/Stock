//
//  CustomAlert.swift
//  Stock
//
//  Created by TXB4 on 10/09/2020.
//  Copyright © 2020 TobaIbrahim. All rights reserved.
//


import UIKit

class CustomAlert: UIViewController {
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius  = 16
        view.layer.borderWidth   =  2
        view.layer.borderColor   = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor     = .systemBackground
        return view
    }()

    let actionButton  = CustomButton(backgroundColor:Colours.loginButton, title: "Okay", size: 10)
    let titleLabel    = CustomTitleLabel(textAlignment:.center, fontsSize: 20)
    let messageLabel  = CustomBodyLabel(textAlignment: .center, fontsSize: 15)
    
    var alertTitle:String?
    var message: String?
    var buttonTitle:String?
    var padding:CGFloat = 20
    
    
    init(alertTitle:String,message:String,buttonTitle:String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle  = alertTitle
        self.message     = message
        self.buttonTitle = buttonTitle
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
            ])
}

    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        titleLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, paddingTop: padding, paddingLeft: padding,paddingRight: padding, width: 28)
    }
    
    func configureActionButton () {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        actionButton.anchor(leading:containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, paddingLeft: padding, paddingBottom: padding, paddingRight: padding, height: 44)
    
        }
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.anchor(top: titleLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: actionButton.topAnchor, trailing: containerView.trailingAnchor, paddingTop: 8, paddingLeft: padding, paddingBottom: -12, paddingRight: padding)
    }
    
    
    @objc func dismissVC () {
        dismiss(animated: true, completion: nil)
    }
}
