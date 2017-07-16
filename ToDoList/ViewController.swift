//
//  ViewController.swift
//  ToDoList
//
//  Created by Seth Bishop on 7/14/17.
//  Copyright © 2017 Seth Bishop. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var tasks = [Task]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    let todoTask = NSEntityDescription.insertNewObject(forEntityName: "Task", into: managedObjectContext) as! ToDoTask
    
    func fetchAllToDoTasks() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do{
            let result = try managedObjectContext.fetch(request)
            tasks = result as! [Task]
        } catch {
            print("\(error)")
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.detailTextLabel?.text = task.title
        
        return cell
    }
    
}
