//
//  CreateCompanyController.swift
//  CoreDataApp
//
//  Created by Victor Lee on 31/10/17.
//  Copyright © 2017 VictorLee. All rights reserved.
//

import UIKit

class CreateCompanyController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlue
        
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
//        setupNavigationStyle() // not needed after refactor
    }
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
        print("Cancelled create company")
    }
    
    
}
// Can delete this extension after refactoring into appearance() proxy
//extension UIViewController {
//    func setupNavigationStyle(){
//
//    }
//}

