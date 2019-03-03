//
//  ViewController.swift
//  ToDoList
//
//  Created by Alpha.giel DeAsis on 2/19/19.
//  Copyright © 2019 Alpha.giel DeAsis. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.0, *)
class ToDoListViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var itemArray = [Item]() //array of item objects
    var alertTextFieldInput = UITextField()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //an object that provides an interface to the filesystem
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Here we create our own plist file called items.plist, we deleted our reference to userDefaults
        print(dataFilePath!)
        //path where the data is being stored in this app
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        //set tableview as a delegate of the search bar controller
        searchBar.delegate = self;
        loadItems()
        
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
        
        // let textField = UITextField()
        
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
                
                let newItem = Item(context: self.context)
                newItem.title = self.alertTextFieldInput.text!
                newItem.isDone = false;
                self.itemArray.append(newItem)
                //self.defaults.set(self.itemArray, forKey: "ToDoListArray")
                self.saveData()
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
        
        
        //MARK: Delete data
        //context.delete(itemArray[indexPath.row]); //method to remove the data, sepecify the NSManage object at current row
        //itemArray.remove(at: indexPath.row) //remove items in a particular index
        saveData()
    }
    
    func saveData(){
        
        do {
            //commit our context to our storage
            try context.save()
        } catch {
            print("error has occured \(error)")
        }
        
        tableView.reloadData();
    }
    
    //MARK: external internal paramters with default value
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){
        do {
            itemArray = try context.fetch(request); // like context.save() we need to add "try" and encapsulate it in a do catch block
        } catch {
            print("error in fetching data requests = ", error)
        }
    }
}


//MARK: search methods
@available(iOS 10.0, *)
extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        //MARK: NSPredicates =  Foundation class that specifies how data should be fetched or filtered. Its query language, which is like a cross between a SQL WHERE clause and a regular expression
        //in order to query objects in core data we use NSPreidcates
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@" , searchBar.text!);
        //MARK: Sort using NSSortDescriptor
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        //add sortDescriptors(plural) to our requests
        
        //Now fetch data with the rules that we specified in previous lines
        loadItems(with: request)
    }
    
}
    

    

    


