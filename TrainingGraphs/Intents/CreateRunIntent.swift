//
//  NewRunIntent.swift
//  TrainingGraphs
//
//  Created by Eduardo Bertol on 08/12/25.
//

import AppIntents
import SwiftData
import SwiftUI

struct CreateRunIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Log New Run"
    static var description = IntentDescription("Creates a New Run entry on Run Charts app.")
    static var openAppWhenRun: Bool = false
    
    @Parameter(title: "Distance (km)")
    var distance: Double

    @Parameter(title: "Duration (minutes)")
    var duration: Int
    
    static var parameterSummary: some ParameterSummary {
        Summary("Log a run of \(\.$distance) km in \(\.$duration) minutes")
    }
    
    
    @MainActor
    func perform() async throws -> some IntentResult & ReturnsValue<String?> & ProvidesDialog & ShowsSnippetView {

        let context = DataController.shared.container.mainContext
        
        let newRun = Run(
            date: Date(),
            durationMin: duration,
            distanceKm: distance
        )
        
        context.insert(newRun)
        

        
        do {
            try context.save()
            
            return .result(value: "Saved!",
                           dialog: IntentDialog("Great! New run logged."),
                           view: RunCard(
                                date: newRun.date,
                                durationMin: newRun.durationMin,
                                distanceKm: newRun.distanceKm,
                                pace: newRun.pace
                           ).padding(.horizontal, 16)
            )
            
        } catch {
            return .result(
                value: nil,
                dialog: IntentDialog("Error while saving."),
                view: RunCard(date: Date(), durationMin: 0, distanceKm: 0, pace: 0).padding(.horizontal, 16)
            )
        }
    }
    
}
