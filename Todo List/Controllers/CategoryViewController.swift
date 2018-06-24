//
//  CategoryViewController.swift
//  Todo List
//
//  Created by Mohammad Pahlevan on 6/24/18.
//  Copyright © 2018 Mohammad Pahlevan. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()

    }
    
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a new Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add a Category", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text
            self.categories.append(newCategory)
            self.saveData()
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let catItems = categories[indexPath.row]
        cell.textLabel?.text = catItems.name
        tableView.rowHeight = 80.0
        
        
        return cell
        
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
    //MARK: - Data Manipulation Methods
    func saveData() {
        do {
            try context.save()
        }
        catch{
            print("Error while saving data\(error)")
        }
        tableView.reloadData()
    }
    
    func loadData() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categories = try context.fetch(request)
        }
        catch{
            print("Error while fetching data\(error)")
        }
        tableView.reloadData()
    }
    
}
