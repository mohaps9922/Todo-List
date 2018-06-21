//
//  ViewController.swift
//  Todo List
//
//  Created by Mohammad Pahlevan on 6/21/18.
//  Copyright © 2018 Mohammad Pahlevan. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem = Item()
        newItem.title = "Apply for Visa"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Schedule an appt for an interview"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Get interviewd"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Receive an email"
        itemArray.append(newItem3)
        
        let newItem4 = Item()
        newItem4.title = "Submit your passport"
        itemArray.append(newItem4)
        
        let newItem5 = Item()
        newItem5.title = "Wait till they give you the VISA"
        itemArray.append(newItem5)
        
        let newItem6 = Item()
        newItem6.title = "Travel to the States"
        itemArray.append(newItem6)
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }
    }
    
    
    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        tableView.rowHeight = 80.0
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itemArray[indexPath.row]
        
        item.done = !item.done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Would you like to add a new item?", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // what happens when user clicks on the button
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
    }
    

}

