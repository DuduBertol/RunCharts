//
//  DateRange.swift
//  TrainingGraphs
//
//  Created by Eduardo Bertol on 01/12/25.
//

import Foundation

enum GraphTimeRange: String, CaseIterable, Identifiable {
    case week = "7D"
    case month = "1M"
    case threeMonths = "3M"
    case sixMonths = "6M"
    case year = "1Y"
    
    var id: String { self.rawValue }
    
    // Auxiliar para calcular datas
    var component: Calendar.Component {
        switch self {
        case .week: return .day
        case .month: return .month
        case .threeMonths, .sixMonths: return .month
        case .year: return .year
        }
    }
    
    var value: Int {
        switch self {
        case .week: return 7
        case .month: return 1
        case .threeMonths: return 3
        case .sixMonths: return 6
        case .year: return 1
        }
    }
}
