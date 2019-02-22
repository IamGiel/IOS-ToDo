//
//  ViewController.swift
//  ToDoList
//
//  Created by Alpha.giel DeAsis on 2/19/19.
//  Copyright © 2019 Alpha.giel DeAsis. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Draw a design", "Buy groceries", "Sing a song"];
    
    var alertTextFieldInput = UITextField()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ToDoItemCell")

        let cell = tableView.dequeueReusableCell(withIdentifier:"ToDoItemCell", for: indexPath);
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell;
    }
    
    //MARK: add new items
    
    @IBAction func addToDoItem(_ sender: UIBarButtonItem) {
        
        
        
        let alert = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        let thisAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
             // what will happen when user clicks
            //let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z0-9].*")

            //let userTypedInput = self.alertTextFieldInput.text;
            
            
       
            
            if(self.alertTextFieldInput.text == "" || (self.alertTextFieldInput.text?.trimmingCharacters(in: .whitespaces).isEmpty)!) { //if user did not enter new list
                let alert2 = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
                let oops = UIAlertAction(title: "Add Item", style: .default, handler: { (oopsies) in
                    print("must add item...")
                })
                alert2.addAction(oops)
                self.present(alert2, animated: true, completion: nil)
                
            } else {
                print("success!")
                self.itemArray.append(self.alertTextFieldInput.text!)
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
        //select and deselect checkmark accessory
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
        }
    }
}
    

    

    


