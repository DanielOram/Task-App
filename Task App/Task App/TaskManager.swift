//
//  TaskManager.swift
//  Task App
//
//  Created by Daniel Oram on 28/01/16.
//  Copyright © 2016 Danoram. All rights reserved.
//

import UIKit

var taskMgr = TaskManager()



//NSCoding keys
struct TaskKey {
    static let nameKey = "Name"
    static let descKey = "Description"
    static let dateKey = "Date"
}

//Task class instance
class Task: NSObject, NSCoding {
    
    var name = "Name"
    var desc = "Description"
    var date = "Date"
    
    
    
    
    init(name: String, desc: String?, date: String?) {
        // Initialize stored properties.
        self.name = name
        self.desc = desc!
        self.date = date!
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty {
            print("Task init failed")
            //return nil
        }
    }
    
    
    
    //MARK: NSCoding saving data in memory
    func encodeWithCoder(aCoder: NSCoder){
        //add properties here
        aCoder.encodeObject(name, forKey: TaskKey.nameKey)
        aCoder.encodeObject(desc, forKey: TaskKey.descKey)
        aCoder.encodeObject(date, forKey: TaskKey.dateKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(TaskKey.nameKey) as! String
        let desc = aDecoder.decodeObjectForKey(TaskKey.descKey) as? String
        let date = aDecoder.decodeObjectForKey(TaskKey.dateKey) as? String
        
        // Must call designated initilizer.
        self.init(name: name, desc: desc, date: date)
    }
    
    
    
    
}



class TaskManager: NSObject {
    
    //filepath in memory for storing data
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("tasks")
    
    

    
    
    var tasks = [Task]()
    
    func addTask(name: String, desc: String, date: String){
        tasks.append(Task(name: name, desc: desc, date: date))
    }
    
    
    //MARK: NSCoding
    
    //Save task
    func saveTasks(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tasks, toFile: TaskManager.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save tasks...")
        }
    }
    
    //load array of Tasks if there are any
    func loadTasks() -> [Task]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(TaskManager.ArchiveURL.path!) as? [Task]
    }

}
