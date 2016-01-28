//
//  FirstViewController.swift
//  Task App
//
//  Created by Daniel Oram on 28/01/16.
//  Copyright © 2016 Danoram. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tasksTable : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Load any saved meals, otherwise load sample data.
        print("first view loaded")
        if let savedTasks = taskMgr.loadTasks() {
            taskMgr.tasks = savedTasks
        } else {
            
        }
        
        
        tasksTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: tableview delegates
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return taskMgr.tasks.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default Tasks")
        
        let taskName = taskMgr.tasks[indexPath.row].name as String!
        let taskDate = taskMgr.tasks[indexPath.row].date as String!
        let taskAndDate = String(format: "%-12 - %s", COpaquePointer(taskName.cStringUsingEncoding(NSUTF8StringEncoding)!), COpaquePointer(taskDate.cStringUsingEncoding(NSUTF8StringEncoding)!))
            
        //cell.textLabel?.text = taskAndDate
        cell.textLabel?.text = taskMgr.tasks[indexPath.row].name
        cell.detailTextLabel?.text = taskMgr.tasks[indexPath.row].desc
        cell.imageView?.image = UIImage(named: "first")
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            
            taskMgr.tasks.removeAtIndex(indexPath.row)
            
            //save tasks
            taskMgr.saveTasks()
            
            tasksTable.reloadData()
        }
    }
    
    
    //make sure to reload data after adding a task
    override func viewWillAppear(animated: Bool) {
        tasksTable.reloadData()
    }

}

