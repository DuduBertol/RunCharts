//
//  Train.swift
//  TrainingGraphs
//
//  Created by Eduardo Bertol on 29/10/25.
//

import Foundation

protocol Train: Identifiable, Codable, Hashable{
    var id: UUID { get }
    var date: Date { get set }
    var durationMin: Int { get set }
    
}
