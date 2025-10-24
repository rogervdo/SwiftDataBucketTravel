//
//  TaskListScreen.swift
//  SwiftDataBucketTask
//
//  Created by Rogelio Villarreal on 10/24/25.
//

import SwiftUI
import SwiftData

struct TaskListScreen: View {
    
    @Environment(\.modelContext) private var context
    @State private var isShowingItemSheet = false
    @State private var errorMessage: String?
    @State private var showingErrorAlert = false
    
    @Query(sort: \Task.dateAdded) private var tasks : [Task]
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(tasks){ task in
                    TaskListElement(task: task)
                }
                .onDelete { indexSet in
                    deleteTask(at: indexSet)
                }
            }
            
            .navigationTitle("Task Goals")
            .navigationBarTitleDisplayMode( .large)
            .sheet(isPresented: $isShowingItemSheet) {
                AddTaskSheet()
            }
            .toolbar{
                Button("Add", systemImage: "plus"){
                    isShowingItemSheet = true
                }
            }
            .alert("Error", isPresented: $showingErrorAlert) {
                Button("OK") { }
            } message: {
                Text(errorMessage ?? "An unknown error occurred")
            }
        }
    }
    
    private func deleteTask(at indexSet: IndexSet) {
        indexSet.forEach { index in
            guard index < tasks.count else {
                showError("Invalid task selection")
                return
            }
            
            let task = tasks[index]
            context.delete(task)
        }
        
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            showError("Failed to save changes: \(error.localizedDescription)")
        }
    }
    
    private func showError(_ message: String) {
        errorMessage = message
        showingErrorAlert = true
    }
}

#Preview {
    TaskListScreen()
        .modelContainer(for: [Task.self], inMemory: true)
}
