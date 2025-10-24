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
    @State private var errorMessage: String?
    @State private var showingErrorAlert = false
    
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
                        saveTask()
                    }
                    .disabled(!Task.isValidName(name))
                }
            }
            .alert("Error", isPresented: $showingErrorAlert) {
                Button("OK") { }
            } message: {
                Text(errorMessage ?? "An unknown error occurred")
            }
        }
    }
    
    
    private func saveTask() {
        guard Task.isValidName(name) else {
            showError("Please enter a valid task name")
            return
        }
        
        do {
            if isEditMode {
                // Actualizar tarea
                guard let existingTask = taskToEdit else {
                    showError("Unable to find the task to edit")
                    return
                }
                existingTask.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
                existingTask.dateAdded = dateAdded
                existingTask.completed = completed
            } else {
                // Crear nueva
                let task = Task(
                    name: name.trimmingCharacters(in: .whitespacesAndNewlines),
                    dateAdded: dateAdded,
                    completed: completed
                )
                context.insert(task)
            }
            
            try context.save()
            dismiss()
            
        } catch {
            showError("Failed to save task: \(error.localizedDescription)")
        }
    }
    
    private func showError(_ message: String) {
        errorMessage = message
        showingErrorAlert = true
    }
    
}
#Preview("Add Mode") {
    AddTaskSheet()
}

#Preview("Edit Mode") {
    let sampleGoal = Task(name: "Paris", dateAdded: Date(), completed: false)
    return AddTaskSheet(taskToEdit: sampleGoal)
}
