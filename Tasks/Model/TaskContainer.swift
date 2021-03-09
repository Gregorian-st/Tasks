//
//  TaskContainer.swift
//  Tasks
//
//  Created by Grigory Stolyarov on 08.03.2021.
//

import Foundation

class TaskContainer: Task {
    
    var name: String
    var parentTask: TaskContainer?
    var tasks: [Task] = []
    var taskCount: Int {
        get {
            return tasks.count
        }
    }
    var path: String {
        get {
            guard let parentTask = parentTask
            else {
                return "\\" + name
            }
            return parentTask.path + "\\" + name
        }
    }
    
    init(name: String, parentTask: TaskContainer?) {
        self.name = name
        self.parentTask = parentTask
    }
    
}
