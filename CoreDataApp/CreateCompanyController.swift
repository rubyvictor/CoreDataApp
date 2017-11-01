//
//  CreateCompanyController.swift
//  CoreDataApp
//
//  Created by Victor Lee on 31/10/17.
//  Copyright © 2017 VictorLee. All rights reserved.
//

import UIKit

class CreateCompanyController: UIViewController {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name1"
//        label.backgroundColor = .tealColor
        label.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        return label
    }()
    
    let nameTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        view.backgroundColor = .darkBlue
        
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
//        setupNavigationStyle() // not needed after refactor
    }
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
        print("Cancelled create company")
    }
    
    func setupUI(){
        let lightBlueBackgroundView = UIView()
        lightBlueBackgroundView.backgroundColor = .lightBlue
        lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lightBlueBackgroundView)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        
        lightBlueBackgroundView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        lightBlueBackgroundView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        lightBlueBackgroundView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        lightBlueBackgroundView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: lightBlueBackgroundView.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        
    }
}








// Can delete this extension after refactoring into appearance() proxy
//extension UIViewController {
//    func setupNavigationStyle(){
//
//    }
//}

