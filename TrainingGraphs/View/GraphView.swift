//
//  GraphView.swift
//  TrainingGraphs
//
//  Created by Eduardo Bertol on 29/10/25.
//

import SwiftUI
import SwiftData
import Charts

enum RunUnits: String, CaseIterable {
    case distance = "Distance"
    case durationMin = "Duration"
    case pace = "Pace"
    
    var unit: String {
        switch self {
        case .distance: return "km"
        case .durationMin: return "min"
        case .pace: return "min/km"
        }
    }
    
    var color: Color {
        switch self {
        case .distance: return .blue
        case .durationMin: return .green
        case .pace: return .orange
        }
    }
    
    func value(of run: Run) -> Double {
        switch self {
        case .distance:
            return run.distanceKm
        case .durationMin:
            return Double(run.durationMin)
        case .pace:
            return run.pace
        }
    }
}

struct GraphView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Run.date) private var runs: [Run]
//    let runs = Run.mockArrayRuns()
    
    @State var selectedRunUnit: RunUnits = .distance
    
    var body: some View {
        VStack(spacing: 32){
            Text("Training Graphs")
            
            ScrollView(.horizontal, showsIndicators: false){
                
                //MARK: - Unit Selector
                HStack(spacing: 12) {
                    ForEach(RunUnits.allCases, id: \.self) { unit in
                        Button{
                            withAnimation(.spring(response: 0.3)) {
                                selectedRunUnit = unit
                            }
                        } label: {
                            HStack(spacing: 8){
                                Circle()
                                    .fill(unit.color)
                                    .frame(width: 8, height: 8)
                                
                                Text(unit.rawValue)
                                    .font(.subheadline.weight(.medium))
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(selectedRunUnit == unit ? unit.color.opacity(0.2) : Color(.systemGray6))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(
                                        selectedRunUnit == unit ? unit.color : Color.clear,
                                        lineWidth: 2
                                    )
                            )
                            
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 4)
                .frame(height: 50)
            }
            
            
            Chart(runs) { run in //Chart deve ter um ForEach interno
                //LINE
                LineMark(
                    x: .value("Date", run.date),
                    y: .value("Value", selectedRunUnit.value(of: run))
                )
                .foregroundStyle(selectedRunUnit.color.gradient) //pq gradient?
                .lineStyle(StrokeStyle(lineWidth: 3))
                .interpolationMethod(.catmullRom)
                
                //AREA
                AreaMark(
                    x: .value("Date", run.date),
                    y: .value("Value", selectedRunUnit.value(of: run))
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [selectedRunUnit.color.opacity(0.3), selectedRunUnit.color.opacity(0.0)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
                //POINT
                PointMark(
                    x: .value("Date", run.date),
                    y: .value("Value", selectedRunUnit.value(of: run))
                )
                .foregroundStyle(selectedRunUnit.color)
                .symbolSize(80)
                
            }
            .chartXAxis{
                AxisMarks(values: .automatic) { _ in
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.day().month())
                }
            }
            .chartYAxis{
                AxisMarks(position: .leading) { value in
                    AxisGridLine()
                    AxisValueLabel {
                        if let val = value.as(Double.self) {
                            Text("\(val, specifier: "%.1f") \(selectedRunUnit.unit)")
                        }
                    }
                }
            }
            .frame(height: 280)
            .padding(.vertical)
            
            HStack(spacing: 16){
                statsView(
                    title: "Média",
                    value: calculateAverage(),
                    icon: "chart.bar.fill"
                )
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
        
    }
    
    
    @ViewBuilder
    func statsView(title: String, value: String, icon: String) -> some View {
        VStack(spacing: 8){
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(selectedRunUnit.color)
            
            VStack(spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(value)
                    .font(.headline)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(selectedRunUnit.color.opacity(0.1))
        .cornerRadius(12)
    }
    
    func calculateAverage() -> String {
        let values = runs.map { selectedRunUnit.value(of: $0) }
        let average = values.reduce(0, +) / Double(values.count)
        return String(format: "%.1f %@", average, selectedRunUnit.unit)
    }

}

#Preview {
    GraphView()
}
