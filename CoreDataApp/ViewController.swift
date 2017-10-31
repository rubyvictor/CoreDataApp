//
//  ViewController.swift
//  CoreDataApp
//
//  Created by Victor Lee on 31/10/17.
//  Copyright © 2017 VictorLee. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var companies: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationStyle()

        companies.append("hello")
        companies.append("new hello")
        companies.append("again hi there")
        companies.append("hey hey hey")
        
        view.backgroundColor = .white
        tableView.backgroundColor = UIColor.rgb(r: 9, g: 45, b: 64)
//        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
    }

    @objc func handleAddCompany(){
        print("Adding company")
    }
    
    func setupNavigationStyle(){
        navigationController?.navigationBar.isTranslucent = false
        
        let lightRed = UIColor.rgb(r: 247, g: 66, b: 82)
        navigationController?.navigationBar.barTintColor = lightRed
        
        navigationItem.title = "Companies"
        navigationController?.navigationBar.prefersLargeTitles = true
        //titleTextAttributes for small title at top of navbar
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        //LargeTitleTextAttributes for large title when static
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)

        cell.textLabel?.text = companies[indexPath.row]
        
        return cell
    }

    
}

extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

