//
//  ViewController.swift
//  CoreDataSample
//
//  Created by Sujin Shrestha on 12/6/18.
//  Copyright © 2018 Sujin Shrestha. All rights reserved.
//

import UIKit
import CoreData

//Gloabl variables and constants
let appDelegate = UIApplication.shared.delegate as? AppDelegate

class ViewController: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var tv: UITableView!
    
    //Variables
    var taskArray = [Task]()
    
    //Constants
    let cellid = "CellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cellDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchInitialData()
        tv.reloadData()
    }
    
    func fetchInitialData() {
        fetchData { (done) in
            if done {
                if taskArray.count > 0 {
                    tv.isHidden = false
                } else {
                    tv.isHidden = true
                }
            }
        }
    }
    
    func cellDelegates() {
        tv.delegate = self
        tv.dataSource = self
        tv.isHidden = true
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! TableViewCell
        let task = taskArray[indexPath.row]
        cell.taskLbl.text = task.taskDescription
        if task.taskStatus == true {
            cell.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            cell.taskLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in
            self.deleteData(indexPath: index)
            self.fetchInitialData()
            tableView.deleteRows(at: [index], with: .automatic)
        }
        
        let updateAction = UITableViewRowAction(style: .normal, title: "Completed") { (action, index) in
            self.updateData(indexPath: index)
            self.fetchInitialData()
            tableView.reloadRows(at: [index], with: .automatic)
        }
        
        updateAction.backgroundColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        return [deleteAction, updateAction]
    }
    
    
}

extension ViewController {
    func fetchData(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do {
            taskArray = try managedContext.fetch(request) as! [Task]
            print("Data fetch success :3")
            completion(true)
        } catch {
            print("Unable to fetch data:", error.localizedDescription)
            completion(false)
        }
    }
    
    func deleteData(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(taskArray[indexPath.row])
        do {
            try managedContext.save()
            print("Data deleted")
            
        } catch {
            print("Unable to fetch data:", error.localizedDescription)
        }
    }
    
    func updateData(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let task = taskArray[indexPath.row]
        if task.taskStatus == true {
            task.taskStatus = false
        } else {
            task.taskStatus = true
        }
        do {
            try managedContext.save()
            print("Data updated")
            
        } catch {
            print("Unable to fetch data:", error.localizedDescription)
        }
    }
}
