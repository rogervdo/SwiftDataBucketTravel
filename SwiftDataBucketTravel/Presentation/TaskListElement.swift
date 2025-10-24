//
//  TaskListElement.swift
//  SwiftDataBucketTask
//
//  Created by Rogelio Villarreal on 10/24/25.
//

import SwiftUI
import SwiftData

struct TaskListElement: View {
    let task: Task
    @State private var showingEditSheet = false
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(task.name)
                    .font(.headline)
                Spacer()
                Text(task.dateAdded, style: .date)
                    .font(.subheadline)
            }
            Text(task.completed ? "Completed" : "Not Completed")
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture {
            showingEditSheet = true
        }
        .sheet(isPresented: $showingEditSheet) {
            AddTaskSheet(taskToEdit: task)
        }
    }
}

#Preview {
    TaskListElement(task: Task(name: "Roger", dateAdded: Date(), completed: true))
}
