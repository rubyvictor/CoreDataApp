//
//  CreateCompanyController.swift
//  CoreDataApp
//
//  Created by Victor Lee on 31/10/17.
//  Copyright © 2017 VictorLee. All rights reserved.
//

import UIKit
import CoreData

//Custom Delegation
// Benefit: This class is Not tightly coupled with CompaniesController class.
protocol CreateCompanyControllerDelegate {
    func didAddCompany(company: Company)
}

class CreateCompanyController: UIViewController {
    
    var company: Company? {
        didSet {
            nameTextField.text = company?.name
        }
    }
    
//    var companiesController = CompaniesController() //refactor to delegate
    var delegate: CreateCompanyControllerDelegate?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ternary to check if edit or create company
        navigationItem.title = company == nil ? "Create Company" : "Edit Company"
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        view.backgroundColor = .darkBlue
        
        setupNavItems()
        
    }
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
        print("Cancelled create company")
    }
    @objc func handleSave(){
        print("Save company")
        
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
            let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
            company.setValue(self.nameTextField.text, forKey: "name")
        
            // Perform the save
            do {
                try context.save()
                print("Successfully saved Company:\(company)")
                // Success
                self.dismiss(animated: true, completion: {
                    self.delegate?.didAddCompany(company: company as! Company)
                })
            } catch let saveError {
                print("Failed to save Company: \(saveError)")
            }
            
            
        }
    
    func setupNavItems(){
//        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
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

