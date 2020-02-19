//
//  ViewController.swift
//  ToDoLister
//
//  Created by Abhijit Kawle on 27/01/2020.
//  Copyright © 2020 Harbor Ops. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = item()
        newItem.title = "Item 1 Afer MVC Implementation"
        itemArray.append(newItem)
        
        let newItem2 = item()
        newItem.title = "Item 1 Afer MVC Implementation"
        itemArray.append(newItem2)
        
        let newItem3 = item()
        newItem.title = "Item 1 Afer MVC Implementation"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [item] {
            itemArray = items
        }
        // Do any additional setup after loading the view.
    }
//MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
}
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    
    }

    
    
//MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//MARK - Add new Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New To Do list Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What happens when User clicks on the add button
            
            let newItem = item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
}