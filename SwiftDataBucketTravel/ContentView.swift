//
//  ContentView.swift
//  SwiftDataBucketTravel
//
//  Created by Rogelio Villarreal on 10/20/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        TabView{
            Tab("Tasks", systemImage: "person"){
                TaskListScreen()
            }
        }
    }
}

#Preview {
    ContentView()
}
