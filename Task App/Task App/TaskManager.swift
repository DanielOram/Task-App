//
//  TaskManager.swift
//  Task App
//
//  Created by Daniel Oram on 28/01/16.
//  Copyright © 2016 Danoram. All rights reserved.
//

import UIKit

var taskMgr = TaskManager()

struct Task {
    var name = "Name"
    var desc = "Description"
}

class TaskManager: NSObject {
    var tasks = [Task]()
    
    func addTask(name: String, desc: String){
        tasks.append(Task(name: name, desc: desc))
    }
}
