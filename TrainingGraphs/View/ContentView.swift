//
//  ContentView.swift
//  TrainingGraphs
//
//  Created by Eduardo Bertol on 28/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    var body: some View {
        TabView{
            Tab("", systemImage: "plus"){
                NewTrainView()
            }
            Tab("", systemImage: "chart.xyaxis.line"){
                GraphView()
            }
            Tab("", systemImage: "bag.badge.plus"){
                GraphPlusView()
            }
            Tab("", systemImage: "clock"){
                HistoryView()
            }
        }
        .modelContainer(for: Run.self)
    }
}

#Preview {
    ContentView()
}
