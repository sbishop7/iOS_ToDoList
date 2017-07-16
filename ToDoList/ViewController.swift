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
    
    
    @IBAction func newTaskCreated(_ segue: UIStoryboardSegue) {
        
        let controller = segue.source as! AddTaskViewController
        let todoTask = NSEntityDescription.insertNewObject(forEntityName: "Task", into: managedObjectContext) as! Task
        
        todoTask.title = controller.todoTaskLabel.text
        todoTask.notes = controller.notesLabel.text
        todoTask.dueDate = controller.datePickerLabel.date as NSDate?
        todoTask.completed = false
        
        saveManagedObjectContext()
        
        tasks.append(todoTask)
        tableView.reloadData()
    }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func fetchAllToDoTasks() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do{
            let result = try managedObjectContext.fetch(request)
            tasks = result as! [Task]
        } catch {
            print("\(error)")
        }
        
    }
    
    func saveManagedObjectContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllToDoTasks()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        let task = tasks[indexPath.row]
        cell.titleLabel?.text = task.title
        cell.notesLabel.text = task.notes
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: task.dueDate! as Date)
        cell.dateLabel.text = dateString
        
        if task.completed {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let todoTask = self.tasks[indexPath.row]
        todoTask.completed = !todoTask.completed
        saveManagedObjectContext()
        
        let cell = tableView.cellForRow(at: indexPath)
        if todoTask.completed {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        
    }
    
}
