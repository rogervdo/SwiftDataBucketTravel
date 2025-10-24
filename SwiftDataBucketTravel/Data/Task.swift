//
//  Task.swift
//  SwiftDataBucketTask
//
//  Created by Rogelio Villarreal on 10/20/25.
//

import Foundation
import SwiftData

@Model
class Task {
    var name : String
    var taskDesc : String?
    var dateAdded : Date
    var completed : Bool
    
    init (name: String, taskDesc: String, dateAdded: Date, completed: Bool){
        self.name = name
        self.taskDesc = taskDesc
        self.dateAdded = dateAdded
        self.completed = completed
    }
    
    static func isValidName(_ name: String) -> Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
