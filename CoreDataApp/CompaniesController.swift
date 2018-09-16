//
//  ViewController.swift
//  CoreDataApp
//
//  Created by Victor Lee on 31/10/17.
//  Copyright © 2017 VictorLee. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController, CreateCompanyControllerDelegate {
    
     var companies = [Company?]()
    
    func didAddCompany(company: Company) {
        // Code from original addCompany(company: Company) method goes here after refactor
        companies.append(company)
        
        //2: insert a new indexPath into Company array
        let newIndexPath = IndexPath(row: companies.count-1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }

    func didEditCompany(company: Company) {
        // update my tableview
        guard let row = companies.index(of: company) else { return }
        let reloadIndexPath = IndexPath(row: row, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .automatic)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //test add:
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "test+", style: .plain, target: self, action: #selector(addCompany))
        
//        setupNavigationStyle() // Not needed after refactor via appearance() proxy

//        companies.append(Company(name: "ABC wow!", founded: Date()))
//        companies.append(Company(name: "Apple inc", founded: Date()))
//        companies.append(Company(name: "Wow inc", founded: Date()))
//        companies.append(Company(name: "Amazing inc", founded: Date()))
//
//        for company in companies {
//            guard let name = company?.name else { return }
//            print(name)
//        }
        
        fetchCompanies()
        
        navigationItem.title = "Companies"
        
        view.backgroundColor = .white
        tableView.backgroundColor = UIColor.darkBlue
//        tableView.separatorStyle = .none
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView() //blank view to get rid of lines below
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
    }
    
    
    private func fetchCompanies(){
        // Initialize CoreData for NSFetchRequest(entityName: String)
        //        let persistentContainer = NSPersistentContainer(name: "Company")
        //        persistentContainer.loadPersistentStores { (storeDescription, error) in
        //            if let error = error {
        //                fatalError("Loading of store failed: \(error)")
        //            }
        //            let context = persistentContainer.viewContext
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            
            for company in companies {
                print(company.name ?? "")
            }
            
            // Display companies after fetching
            self.companies = companies
            self.tableView.reloadData()
            
        } catch let fetchError {
            print("Failed to fetch companies:", fetchError)
        }
    }

    // To pass data from createCompanyController to CompaniesController
    // 3 steps
    // Step 1: create reference in createCompanyController to CompaniesController()
    // Step 2: Inside HandleAddCompany, set that reference to self
    // Step 3: Modify AddCompany to take in param company
    // Steps 1-3 above and this addCompany method is no longer needed after implementing custom Delegation

//    func addCompany(company: Company){
////        let honda = Company(name: "Honda inc", founded: Date())
//
//        //1: modify array
//        companies.append(company)
//
//        //2: insert a new indexPath into Company array
//        let newIndexPath = IndexPath(row: companies.count-1, section: 0)
//        tableView.insertRows(at: [newIndexPath], with: .automatic)
//    }
    
    @objc func handleAddCompany(){
        print("adding company")
        //Present CreateCompanyController using Modal style.i.e. from bottom up
        let createCompanyController = CreateCompanyController()
        
        //Subclass CustomNavigationController for statusBarStyle
        let navController = CustomNavigationController(rootViewController: createCompanyController)
//        createCompanyController.companiesController = self
        createCompanyController.delegate = self // This class MUST conform to protocol and implement the method didAddCompany()
        present(navController, animated: true, completion: nil)
    }
    
    // Delete by swiping
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            guard let company = self.companies[indexPath.row] else { return }
            
            // Remove company from tableView
            self.companies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            print("Attempting to delete company:",company.name ?? "")
            
            
            // Delete company from CoreData
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(company)
            // Need to persist the deletion
            do {
                try context.save()
            } catch let saveError {
                print("Failed to delete company:",saveError)
            }
        }
        
        deleteAction.backgroundColor = UIColor.lightRed
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandlerFunction)
        
        editAction.backgroundColor = UIColor.darkBlue

        return [deleteAction,editAction]
    }
    
    private func editHandlerFunction (action: UITableViewRowAction, indexPath: IndexPath) {
        print("Editing company in separate function")
        
        // Create modal for edit company
        let editCompanyController = CreateCompanyController()
        editCompanyController.company = companies[indexPath.row]
        // set delegate to self to conform to implement didEditCompany delegate method
        editCompanyController.delegate = self
        let navController = CustomNavigationController(rootViewController: editCompanyController)
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
        cell.backgroundColor = UIColor.tealColor
        //        cell.backgroundColor = .tealColor
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        if let company = companies[indexPath.row] {
            cell.textLabel?.text = company.name
        }
        
        return cell
    }

    
}



