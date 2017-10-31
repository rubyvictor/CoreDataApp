//
//  ViewController.swift
//  CoreDataApp
//
//  Created by Victor Lee on 31/10/17.
//  Copyright © 2017 VictorLee. All rights reserved.
//

import UIKit

class CompaniesController: UITableViewController {

    var companies = [Company?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationStyle() // Access nav style via extension

        companies.append(Company(name: "ABC wow!", founded: Date()))
        companies.append(Company(name: "Apple inc", founded: Date()))
        companies.append(Company(name: "Wow inc", founded: Date()))
        companies.append(Company(name: "Amazing inc", founded: Date()))
        
        for company in companies {
            guard let name = company?.name else { return }
            print(name)
        }
        
        navigationItem.title = "Companies"
        
        view.backgroundColor = .white
        tableView.backgroundColor = UIColor.rgb(r: 9, g: 45, b: 64)
//        tableView.separatorStyle = .none
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView() //blank view to get rid of lines below
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
    }

    @objc func handleAddCompany(){
        print("adding company")
        //Present CreateCompanyController using Modal style.i.e. from bottom up
        let createCompanyController = CreateCompanyController()
//        createCompanyController.view.backgroundColor = .purple
        let navController = UINavigationController(rootViewController: createCompanyController)
        present(navController, animated: true, completion: nil)
    }
    

    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)

        // set cell colors to tealColor
        cell.backgroundColor = UIColor.rgb(r: 48, g: 164, b: 182)
        //        cell.backgroundColor = .tealColor
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        if let company = companies[indexPath.row] {
            cell.textLabel?.text = company.name
        }
        
        return cell
    }

    
}

extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    // Or hard code the actual color themes like this
    static let tealColor = UIColor(red: 48/255, green: 164/255, blue: 182/255, alpha: 1)
    
    static let lightBlue = UIColor(red: 218/255, green: 235/255, blue: 243/255, alpha: 1)
    
    static let darkBlue = UIColor(red: 9/255, green: 45/255, blue: 64/255, alpha: 1)
}
