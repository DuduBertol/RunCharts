//
//  RunTrain.swift
//  TrainingGraphs
//
//  Created by Eduardo Bertol on 29/10/25.
//

import Foundation
import SwiftData

@Model
class Run {
    var id: UUID
    var date: Date
    var durationMin: Int
    var distanceKm: Double
    var pace: Double {
        distanceKm > 0 ? Double(durationMin) / distanceKm : 0
    }
     
    
    init(date: Date = Date(), durationMin: Int, distanceKm: Double) {
        self.id = UUID()
        self.date = date
        self.durationMin = durationMin
        
        self.distanceKm = distanceKm
    }
}

//MOCKS
extension Run {
    static func mockRun() -> Run {
        Run(date: Date(), durationMin: 60, distanceKm: 10.0)
    }
    
    static func mockArrayRunsSameDate() -> [Run] {
        [
            Run(durationMin: 60, distanceKm: 6),
            Run(durationMin: 60, distanceKm: 9),
            Run(durationMin: 60, distanceKm: 3),
            Run(durationMin: 60, distanceKm: 15),
            Run(durationMin: 60, distanceKm: 5),
            Run(durationMin: 60, distanceKm: 6),
            Run(durationMin: 60, distanceKm: 8),
            Run(durationMin: 60, distanceKm: 5),
            Run(durationMin: 60, distanceKm: 15),
            Run(durationMin: 60, distanceKm: 1),
        ]
    }
    
    static func mockArrayRuns() -> [Run] {
        [
            Run(
                date: Date.dateCreator(year: 2025, month: 10, day: 29),
                durationMin: 60,
                distanceKm: 10
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 10, day: 28),
                durationMin: 45,
                distanceKm: 8
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 10, day: 27),
                durationMin: 120,
                distanceKm: 20
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 10, day: 26),
                durationMin: 30,
                distanceKm: 4
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 10, day: 25),
                durationMin: 75,
                distanceKm: 12
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 10, day: 24),
                durationMin: 75,
                distanceKm: 14
            ),
        ]
    }
}

extension Run {
    var dateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

extension Date {
    static func dateCreator(year: Int, month: Int, day: Int) -> Date {
        Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
    }
}


