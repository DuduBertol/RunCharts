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
    
    static func mockExampleRuns() -> [Run] {
        [
            Run(
                date: Date.dateCreator(year: 2025, month: 12, day: 1), 
                durationMin: 45,
                distanceKm: 8.0
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 11, day: 29),
                durationMin: 60,
                distanceKm: 10.0
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 11, day: 27),
                durationMin: 30,
                distanceKm: 5.0
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 11, day: 20),
                durationMin: 90, // Longão de feriado
                distanceKm: 15.0
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 11, day: 15),
                durationMin: 50,
                distanceKm: 9.0
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 11, day: 8),
                durationMin: 40,
                distanceKm: 7.0
            ),
        ]
    }
    
    static func mockArrayRuns() -> [Run] {
        [
            // ==========================================
            // 📅 "HOJE" (DATA BASE DO MOCK: 01/DEZ/2025)
            // ==========================================
            
            // --- 7 DIAS (Visível em: 7D, 1M, 3M, 6M, 1Y) ---
            Run(
                date: Date.dateCreator(year: 2025, month: 12, day: 1), // Hoje simulado
                durationMin: 45,
                distanceKm: 8.0
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 11, day: 29), // Sexta-feira
                durationMin: 60,
                distanceKm: 10.0
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 11, day: 27), // Quarta-feira
                durationMin: 30,
                distanceKm: 5.0
            ),
            
            // --- 1 MÊS (Visível em: 1M, 3M, 6M, 1Y) ---
            // Datas entre 01/Nov e 24/Nov
            Run(
                date: Date.dateCreator(year: 2025, month: 11, day: 20),
                durationMin: 90, // Longão de feriado
                distanceKm: 15.0
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 11, day: 15),
                durationMin: 50,
                distanceKm: 9.0
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 11, day: 8),
                durationMin: 40,
                distanceKm: 7.0
            ),
            
            // --- 3 MESES (Visível em: 3M, 6M, 1Y) ---
            // Datas em Setembro e Outubro
            Run(
                date: Date.dateCreator(year: 2025, month: 10, day: 31), // Halloween Run
                durationMin: 55,
                distanceKm: 10.0
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 10, day: 12),
                durationMin: 120, // Meia Maratona Treino
                distanceKm: 21.0
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 9, day: 25),
                durationMin: 45,
                distanceKm: 8.5
            ),
            
            // --- 6 MESES (Visível em: 6M, 1Y) ---
            // Datas em Junho, Julho, Agosto
            Run(
                date: Date.dateCreator(year: 2025, month: 8, day: 10),
                durationMin: 35,
                distanceKm: 5.0
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 7, day: 15), // Frio de Julho
                durationMin: 60,
                distanceKm: 10.5
            ),
            
            // --- 1 ANO (Visível apenas em: 1Y) ---
            // Datas no início de 2025
            Run(
                date: Date.dateCreator(year: 2025, month: 5, day: 20),
                durationMin: 50,
                distanceKm: 9.0
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 2, day: 10), // Carnaval
                durationMin: 45,
                distanceKm: 7.0
            ),
            Run(
                date: Date.dateCreator(year: 2025, month: 1, day: 5), // Começo do ano
                durationMin: 30,
                distanceKm: 5.0
            ),
            
            // --- FORA DO FILTRO (Mais de 1 ano atrás) ---
            // Serve para garantir que o filtro de ano está cortando certo
            Run(
                date: Date.dateCreator(year: 2024, month: 11, day: 1),
                durationMin: 100,
                distanceKm: 18.0
            )
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
            var components = DateComponents()
            components.year = year
            components.month = month
            components.day = day
            // Retorna a data ou "Hoje" caso falhe
            return Calendar.current.date(from: components) ?? Date()
        }
}


