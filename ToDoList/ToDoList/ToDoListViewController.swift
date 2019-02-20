//
//  ViewController.swift
//  ToDoList
//
//  Created by Alpha.giel DeAsis on 2/19/19.
//  Copyright © 2019 Alpha.giel DeAsis. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let itemArray = ["Draw a design", "Buy groceries", "Sing a song"];

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
    

    

    


