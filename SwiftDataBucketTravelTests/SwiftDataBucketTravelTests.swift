//
//  SwiftDataBucketTravelTests.swift
//  SwiftDataBucketTravelTests
//
//  Created by Rogelio Villarreal on 10/23/25.
//

import Testing
import Foundation
@testable import SwiftDataBucketTravel

struct SwiftDataBucketTravelTests {

    @Test("Name must not be empty or whitespace")
    func testNameValidation() async throws {

        #expect(Task.isValidName("Cupertino"))
        #expect(Task.isValidName("San Francisco"))
        #expect(Task.isValidName("A"))
        
        #expect(!Task.isValidName(""))
        #expect(!Task.isValidName("   "))
    }
    
    @Test("Task can be created with valid parameters")
    func testTaskCreation() async throws {
        let name = "Visit Tokyo"
        let taskDesc = "Desc default"
        let dateAdded = Date()
        let completed = false
        
        let task = Task(name: name, taskDesc: taskDesc, dateAdded: dateAdded, completed: completed)
        
        #expect(task.name == name)
        #expect(task.dateAdded == dateAdded)
        #expect(task.completed == completed)
    }
    
    @Test("Task name can be edited")
    func testEditTaskName() async throws {
        let originalName = "Visit Paris"
        let taskDesc = "default!"
        let newName = "Visit Rome"
        let dateAdded = Date()
        
        let task = Task(name: originalName, taskDesc: taskDesc, dateAdded: dateAdded, completed: false)
        #expect(task.name == originalName)
        
        // editar nombre de task
        task.name = newName
        #expect(task.name == newName)
        #expect(task.dateAdded == dateAdded) // otras propriedades no cambian
        #expect(task.completed == false)
    }
}
