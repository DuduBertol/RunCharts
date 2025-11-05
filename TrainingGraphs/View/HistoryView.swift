//
//  HistoryView.swift
//  TrainingGraphs
//
//  Created by Eduardo Bertol on 29/10/25.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Run.date) private var runs: [Run]
    
    @State var showDeleteAlert: Bool = false
    @State var showConfirmDeleteDialog: Bool = false
    
    
    var body: some View {
        VStack{
            List {
                ForEach(runs){ run in
//                    VStack{
//                        Text(run.date.description)
//                        Text("\(run.durationMin)")
//                        Text("\(run.distanceKm)")
//                    }
//                    
                    RunCard(durationMin: run.durationMin, distanceKm: run.distanceKm, pace: run.pace)
                }
                .onDelete{ indexSet in
                    indexSet.forEach{ index in
                        let run = runs[index]
                        context.delete(run)
                    }
                }
            }
            
            
            HStack{
                Spacer()
                Button(role: .destructive) {
                    showDeleteAlert = true
                } label: {
                    Text("Delete all runs")
                }
                .confirmationDialog("Are you sure you want to delete all runs?",
                                    isPresented: $showDeleteAlert,
                                    titleVisibility: .visible) {
                    Button("Delete All Data", role: .destructive) {
                        do {
                            try context.delete(model: Run.self)
                            try context.save()
                            
                            showConfirmDeleteDialog = true
                        } catch {
                            print("Erro ao deletar os dados: \(error)")
                        }
                    }
                    .alert("Successfully Deleted All Runs!", isPresented: $showConfirmDeleteDialog) {}
                    
                } message: {
                    Text("This action is permanent and cannot be undone.")
                }
                
                
                Spacer()
            }
        }
        .padding(.bottom, 32)
    }
}

#Preview {
    HistoryView()
}
