//
//  SwiftDataBucketTravelApp.swift
//  SwiftDataBucketTravel
//
//  Created by Rogelio Villarreal on 10/20/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataBucketTravelApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Task.self])
    }
}
