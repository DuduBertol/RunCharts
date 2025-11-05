//
//  NewTrainViewModel.swift
//  TrainingGraphs
//
//  Created by Eduardo Bertol on 29/10/25.
//

import Foundation
import Combine

class NewTrainViewModel: ObservableObject{
    
    @Published var runs: [Run] = []
    
    func addMockRun(){
        runs.append(Run(durationMin: 60, distanceKm: 10))
    }
    
}
