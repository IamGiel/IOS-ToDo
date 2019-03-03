# IOS-ToDo

Realm, local storage, CRUD operations, SQL

<h2>Making Data Persistent with:</h2>
UserDefaults.Standard // singleton
Codable // storing small amounts of custom objects and saing it into plist file

<h2>Large Data with Database Solutions</h2>
CoreData
SQLite
REALM

Completed: Save Data using CoreData: 238
<br>
Completed: CRUD in CoreData - persistentContainer.viewContext - external internal paramters with default value

<br>

<hr>

<pre>
//MARK: external internal paramters with default value 

    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) { 
        do { 
            itemArray = try context.fetch(request);
        } catch {   
            print("error in fetching data requests = ", error) 
            } 
            
    }
</pre>
<hr>
