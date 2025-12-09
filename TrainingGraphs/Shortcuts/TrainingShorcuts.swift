//
//  TrainingShorcuts.swift
//  TrainingGraphs
//
//  Created by Eduardo Bertol on 08/12/25.
//

import AppIntents

struct TrainingShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: CreateRunIntent(),
            phrases: [
                "Log a run in \(.applicationName)",
                "Add run to \(.applicationName)",
                "New training in \(.applicationName)",
                "Save run in \(.applicationName)",
                "New run in \(.applicationName)"
            ],
            shortTitle: "Log Run",
            systemImageName: "figure.run"
        )
    }
}
