//
//  TrainingGraphsApp.swift
//  TrainingGraphs
//
//  Created by Eduardo Bertol on 28/10/25.
//

import SwiftUI
import SwiftData

@main
struct TrainingGraphsApp: App {
    
    let container = DataController.shared.container
    
    var body: some Scene {
        WindowGroup {
            GraphView()
        }
        .modelContainer(container)
    }
}
