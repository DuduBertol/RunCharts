//
//  DataController.swift
//  TrainingGraphs
//
//  Created by Eduardo Bertol on 08/12/25.
//

import SwiftData
import Foundation

@MainActor
class DataController {
    static let shared = DataController()
    
    let container: ModelContainer
    
    init() {
        do {
            // Define o schema (suas tabelas)
            let schema = Schema([Run.self])
            
            // Configura o armazenamento para usar o App Group
            let modelConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false,
                groupContainer: .identifier("group.com.DuduBertol.RunCharts") 
            )
            
            // Inicializa o container
            container = try ModelContainer(for: schema, configurations: modelConfiguration)
        } catch {
            fatalError("Falha ao inicializar SwiftData com App Group: \(error)")
        }
    }
}
