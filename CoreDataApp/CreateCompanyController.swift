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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        view.backgroundColor = .darkBlue
        
        setupNavItems()
        
        
//        setupNavigationStyle() // not needed after refactor
    }
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
        print("Cancelled create company")
    }
    @objc func handleSave(){
        print("Save company")
        
        // Initialize our Core Data Stack and context
        let persistentContainer = NSPersistentContainer(name: "TrainingModel")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed: \(error)")
            }
            
            let context = persistentContainer.viewContext
            
            let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
            company.setValue(self.nameTextField.text, forKey: "name")
        
            // Perform the save
            do {
                try context.save()
            } catch let saveError {
                print("Failed to save Company: \(saveError)")
            }
            
            
        }
        
        
        
        
        //        dismiss(animated: true, completion: nil) // refactor this to animate after completion block:

//        dismiss(animated: true) {
//            guard let name = self.nameTextField.text else { return }
//
//            let company = Company(name: name, founded: Date())
////            self.companiesController.addCompany(company: company)
//            //refactor to delegate
//            //No need for AddCompany(company: Company) method anymore
//            self.delegate?.didAddCompany(company: company)
//        }
    }
    
    func setupNavItems(){
        navigationItem.title = "Create Company"
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

