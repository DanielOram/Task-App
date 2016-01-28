//
//  TaskManager.swift
//  Task App
//
//  Created by Daniel Oram on 28/01/16.
//  Copyright © 2016 Danoram. All rights reserved.
//

import UIKit

var taskMgr = TaskManager()

//MARK: task struct obselete 
struct Task {
    var name = "Name"
    var desc = "Description"
    
}

//NSCoding keys
struct TaskKey {
    static let nameKey = "Name"
    static let descKey = "Description"
}

//Task class instance
class _Task: NSObject, NSCoding {
    
    var name = "Name"
    var desc = "Description"
    
    //filepath in memory for storing data
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("tasks")
    
    
    init(name: String, desc: String?) {
        // Initialize stored properties.
        self.name = name
        self.desc = desc!
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty {
            print("_Task init failed")
            //return nil
        }
    }
    
    
    
    //MARK: NSCoding saving data in memory
    func encodeWithCoder(aCoder: NSCoder){
        //add properties here
        aCoder.encodeObject(name, forKey: TaskKey.nameKey)
        aCoder.encodeObject(desc, forKey: TaskKey.descKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(TaskKey.nameKey) as! String
        let desc = aDecoder.decodeObjectForKey(TaskKey.descKey) as? String
        
        // Must call designated initilizer.
        self.init(name: name, desc: desc)
    }
    
    
    
    
}



class TaskManager: NSObject {
    var tasks = [Task]()
    
    func addTask(name: String, desc: String){
        tasks.append(Task(name: name, desc: desc))
    }
}
