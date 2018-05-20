//
//  TodoViewController.swift
//  imobiles
//
//  Created by Mohamed Sobhi  Fouda on 5/10/18.
//  Copyright © 2018 Mohamed Sobhi Fouda. All rights reserved.
//

import UIKit
import CoreData

class TodoViewController: UITableViewController {
    
    var items = [Items]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadItems()
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
    }
    @IBAction func MainViewButton(_ sender: UIBarButtonItem) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainView")
        
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion:nil)

        
    }
    
    // MARK: - ADD NEW ITEM
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Items(context: self.context)
            newItem.name = textField.text!
            self.items.append(newItem)
            self.saveItems()
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a New Item"
        }
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - SAVE NEW ITEM TO CORE DATA
    func saveItems(){
        do{
            try context.save()
        }catch {
            print("Error saving item with \(error)")
        }
        tableView.reloadData()
    }
    
    // MARK: - CONFIGURE TABLEVIEW
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        items[indexPath.row].completed = !items[indexPath.row].completed
        saveItems()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            
            let item = items[indexPath.row]
            items.remove(at: indexPath.row)
            context.delete(item)
            
            do {
                try context.save()
            } catch {
                print("Error deleting items with \(error)")
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)  //includes updating UI so reloading is not necessary
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        cell.accessoryType = item.completed ? .checkmark : .none
        
        return cell
        
    }
    
    // MARK: - PREPARE SEGUE
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let item = items[indexPath.row]
                let navigationController = segue.destination as! UINavigationController
                let controller = navigationController.topViewController as! DetailViewController
                controller.item = item
            }
        }
    }
    
    // MARK: - LOAD ITEMS INTO TABLEVIEW
    func loadItems(){
        let request: NSFetchRequest<Items> = Items.fetchRequest()
        do {
            items = try context.fetch(request)
        }catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
}

