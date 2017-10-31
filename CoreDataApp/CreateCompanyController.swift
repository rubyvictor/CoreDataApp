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
        
        setupNavigationStyle()
    }
    
}

extension UIViewController {
    func setupNavigationStyle(){
        navigationController?.navigationBar.isTranslucent = false
        
        let lightRed = UIColor.rgb(r: 247, g: 66, b: 82)
        navigationController?.navigationBar.barTintColor = lightRed
        
        navigationController?.navigationBar.prefersLargeTitles = true
        //titleTextAttributes for small title at top of navbar
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        //LargeTitleTextAttributes for large title when static
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
    }
}
