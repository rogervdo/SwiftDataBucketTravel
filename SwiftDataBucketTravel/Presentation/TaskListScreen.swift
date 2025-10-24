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
    
    @Query(sort: \Task.dateAdded) private var tasks : [Task]
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(tasks){ task in
                    TaskListElement(task: task)
                }
                .onDelete { IndexSet in
                    IndexSet.forEach { index in
                        let task = self.tasks[index]
                        self.context.delete(task)
                        
                        do {
                            try self.context.save()
                        } catch {
                            print(error)
                        }
                    }
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
        }
    }
}

#Preview {
    TaskListScreen()
        .modelContainer(for: [Task.self], inMemory: true)
}
