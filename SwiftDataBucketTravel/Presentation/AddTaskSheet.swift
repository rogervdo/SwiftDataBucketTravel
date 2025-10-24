//
//  AddTaskSheet.swift
//  SwiftDataBucketTask
//
//  Created by Rogelio Villarreal on 10/20/25.
//

import SwiftUI
import SwiftData

struct AddTaskSheet: View{
    

    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context

    @State private var name: String = ""
    @State private var dateAdded : Date = .now
    @State private var completed: Bool = false
    
    let taskToEdit: Task?
    
    // Bool para determinar si estamos en edit mode o no
    private var isEditMode: Bool {
        taskToEdit != nil
    }
    
    // Inicializar con tasktoEdit
    init(taskToEdit: Task? = nil) {
        self.taskToEdit = taskToEdit
    }
    
    var body: some View{
        NavigationStack{
            Form{
                TextField("Task", text: $name)
                DatePicker("Date", selection: $dateAdded, displayedComponents: .date)
                Toggle("Completed", isOn: $completed)
            }
            .navigationTitle(isEditMode ? "Edit Task Goal" : "New Task Goal")
            .navigationBarTitleDisplayMode(.large)
            .onAppear { // POPULAMOS CAMPOS SI EXISTEN YA
                if let existingGoal = taskToEdit {
                    name = existingGoal.name
                    dateAdded = existingGoal.dateAdded
                    completed = existingGoal.completed
                }
            }
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                    
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save"){
                        if isEditMode {
                            // Update existing travel goal
                            if let existingGoal = taskToEdit {
                                existingGoal.name = name
                                existingGoal.dateAdded = dateAdded
                                existingGoal.completed = completed
                            }
                        } else {
                            // Crear
                            let task = Task(name: name, dateAdded:dateAdded, completed:completed)
                            context.insert(task)
                        }
                        
                        try! context.save()
                        dismiss()
                    }
                    .disabled(!Task.isValidName(name))
                }
            }
        }
    }
    
}
#Preview("Add Mode") {
    AddTaskSheet()
}

#Preview("Edit Mode") {
    let sampleGoal = Task(name: "Paris", dateAdded: Date(), completed: false)
    return AddTaskSheet(taskToEdit: sampleGoal)
}
