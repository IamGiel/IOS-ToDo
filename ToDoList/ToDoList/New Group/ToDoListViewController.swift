//
//  ViewController.swift
//  ToDoList
//
//  Created by Alpha.giel DeAsis on 2/19/19.
//  Copyright © 2019 Alpha.giel DeAsis. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]() //array of item objects
    let defaults = UserDefaults.standard;
 
    
    var alertTextFieldInput = UITextField()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let newItem = Item();
        newItem.title = "Find Shiela"
        newItem.isDone = true;
        itemArray.append(newItem)
        
        let newItem2 = Item();
        newItem2.title = "Find Jay"
        itemArray.append(newItem2)
        
        let newItem3 = Item();
        newItem3.title = "Find Heidi"
        itemArray.append(newItem3)
        
    }
    
    //MARK: Delegate Methods here
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellforrowat index path called")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ToDoItemCell")
        let item = itemArray[indexPath.row];
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"ToDoItemCell", for: indexPath);
        cell.textLabel?.text = item.title
        
        //ternary operator ====>
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.isDone ? .checkmark : .none;
        
        return cell;
    }
    
    //MARK: add new items
    
    @IBAction func addToDoItem(_ sender: UIBarButtonItem) {
        
        let textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        let thisAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
             // what will happen when user clicks
            if(self.alertTextFieldInput.text == "" || (self.alertTextFieldInput.text?.trimmingCharacters(in: .whitespaces).isEmpty)!) { //if user did not enter new list
                let alert2 = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
                let oops = UIAlertAction(title: "Add Item", style: .default, handler: { (oopsies) in
                    print("must add item...")
                })
                alert2.addAction(oops)
                self.present(alert2, animated: true, completion: nil)
                
            } else {
                print("success!")
                let newItem = Item()
                newItem.title = textField.text!
                self.itemArray.append(newItem)
                self.defaults.set(self.itemArray, forKey: "ToDoListArray")
                
                print(self.itemArray);
                self.tableView.reloadData();
            }
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "im doing this..."
            //alertTextField.text
            self.alertTextFieldInput = alertTextField;
            //print(alertTextField.text)
        }
        alert.addAction(thisAction)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: tableView didSelectRowAt
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].isDone = !itemArray[indexPath.row].isDone
        
        tableView.reloadData();
        tableView.deselectRow(at: indexPath, animated: true)

    }
}
    

    

    


