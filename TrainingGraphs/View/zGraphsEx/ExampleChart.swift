//
//  ExampleCharts.swift
//  TrainingGraphs
//
//  Created by Eduardo Bertol on 05/12/25.
//


/*
 import SwiftUI
 import Charts
 
 
 struct ExampleChart: View {
 let corridas: [Run]
 @State private var periodoSelecionado: PeriodoFiltro = .mes
 
 var corridasFiltradas: [Run] {
 let agora = Date()
 let calendar = Calendar.current
 
 return corridas.filter { corrida in
 switch periodoSelecionado {
 case .semana:
 return calendar.dateComponents([.day], from: corrida.date, to: agora).day ?? 0 <= 7
 case .mes:
 return calendar.dateComponents([.day], from: corrida.date, to: agora).day ?? 0 <= 30
 case .tresMeses:
 return calendar.dateComponents([.day], from: corrida.date, to: agora).day ?? 0 <= 90
 case .ano:
 return calendar.dateComponents([.day], from: corrida.date, to: agora).day ?? 0 <= 365
 case .tudo:
 return true
 }
 }.sorted { $0.date < $1.date }
 }
 
 var body: some View {
 ScrollView {
 VStack(spacing: 20) {
 Text("Evolução da Distância")
 .font(.headline)
 .padding(.horizontal)
 
 // Gráfico principal
 if !corridasFiltradas.isEmpty {
 VStack(alignment: .leading, spacing: 12) {
 
 Chart(corridasFiltradas) { corrida in
 LineMark(
 x: .value("Data", corrida.date),
 y: .value("Distância", corrida.distanceKm)
 )
 .foregroundStyle(Color.blue.gradient)
 .lineStyle(StrokeStyle(lineWidth: 3))
 .interpolationMethod(.catmullRom)
 
 AreaMark(
 x: .value("Data", corrida.date),
 y: .value("Distância", corrida.distanceKm)
 )
 .foregroundStyle(.blue.opacity(0.25))
 .interpolationMethod(.catmullRom)
 
 PointMark(
 x: .value("Data", corrida.date),
 y: .value("Distância", corrida.distanceKm)
 )
 .foregroundStyle(Color.blue)
 .symbolSize(60)
 }
 .chartXAxis {
 AxisMarks(values: .automatic) { _ in
 AxisGridLine()
 AxisValueLabel(format: formatoData)
 }
 }
 .chartYAxis {
 AxisMarks(position: .leading) { value in
 AxisGridLine()
 AxisValueLabel {
 if let km = value.as(Double.self) {
 Text("\(km, specifier: "%.0f") km")
 }
 }
 }
 }
 .frame(height: 280)
 .padding()
 }
 .background(Color(.systemBackground))
 .cornerRadius(16)
 .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
 .padding(.horizontal)
 } else {
 ContentUnavailableView(
 "Sem Dados",
 systemImage: "chart.line.downtrend.xyaxis",
 description: Text("Nenhuma corrida no período selecionado")
 )
 .frame(height: 300)
 }
 }
 .padding(.vertical)
 }
 .background(Color(.systemGroupedBackground))
 }
 
 var formatoData: Date.FormatStyle {
 switch periodoSelecionado {
 case .semana:
 return .dateTime.weekday().day()
 case .mes, .tresMeses:
 return .dateTime.day().month()
 case .ano, .tudo:
 return .dateTime.month().year()
 }
 }
 }
 
 #Preview {
 ExampleChart(corridas: Run.mockExampleRuns())
 }
 
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
 }
 */
