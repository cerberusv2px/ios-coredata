//
//  TaskViewController.swift
//  CoreDataSample
//
//  Created by Sujin Shrestha on 12/6/18.
//  Copyright © 2018 Sujin Shrestha. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TaskViewController: UIViewController {
    
    //Outlets
    
    @IBOutlet weak var taskTv: UITextView!
    
    //Variables
    
    
    //Constants
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        saveTask { (done) in
            if done {
                print("need to return")
                navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Try again")
            }
        }
    }
    
    func saveTask(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let task = Task(context: managedContext)
        task.taskDescription = taskTv.text
        task.taskStatus = false
        
        do {
            try managedContext.save()
            print("Data Saved")
            completion(true)
        } catch {
            print("Failed to save data: ", error.localizedDescription)
            completion(false)
        }
        
    }
    
}
