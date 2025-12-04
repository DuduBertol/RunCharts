//
//  GraphView.swift
//  TrainingGraphs
//
//  Created by Eduardo Bertol on 29/10/25.
//

import SwiftUI
import SwiftData
import Charts



struct GraphView: View {
    @Environment(\.modelContext) private var context
//    @Query(sort: \Run.date) private var runs: [Run]
    let runs = Run.mockArrayRuns()
    
    @StateObject var vm = GraphViewModel()
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        ScrollView{
            VStack(spacing: 32){
                Text("Graphs")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.opacity(0.5))
                
                VStack{
                    
                    //MARK: - Unit Selector
                    ViewThatFits{
                        
                        HStack(spacing: 12) {
                            ForEach(RunUnits.allCases, id: \.self) { unit in
                                Button{
                                    withAnimation() {
                                        vm.selectedRunUnit = unit
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
                                    .background(vm.selectedRunUnit == unit ? unit.color.opacity(0.2) : Color(.systemGray6))
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(
                                                vm.selectedRunUnit == unit ? unit.color : Color.clear,
                                                lineWidth: 2
                                            )
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 4)
                        .frame(minHeight: 50)
                        
                        VStack(spacing: 12) {
                            ForEach(RunUnits.allCases, id: \.self) { unit in
                                Button{
                                    withAnimation() {
                                        vm.selectedRunUnit = unit
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
                                    .background(vm.selectedRunUnit == unit ? unit.color.opacity(0.2) : Color(.systemGray6))
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(
                                                vm.selectedRunUnit == unit ? unit.color : Color.clear,
                                                lineWidth: 2
                                            )
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 4)
                        .frame(minHeight: 50)
                    }
                }
                
                //MARK: - Chart
                Chart(runs) { run in
                    //LINE
                    LineMark(
                        x: .value("Date", run.date),
                        y: .value("Value", vm.selectedRunUnit.value(of: run))
                    )
                    .foregroundStyle(vm.selectedRunUnit.color)
                    .lineStyle(StrokeStyle(lineWidth: 3))
                    .interpolationMethod(.catmullRom)
                    
                    //AREA
                    AreaMark(
                        x: .value("Date", run.date),
                        yStart: .value("Base", vm.getChartBaseline(for: runs)),
                        yEnd: .value("Value", vm.selectedRunUnit.value(of: run))
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(vm.selectedRunUnit.color.opacity(0.25))
                    
                    //POINT
                    PointMark(
                        x: .value("Date", run.date),
                        y: .value("Value", vm.selectedRunUnit.value(of: run))
                    )
                    .foregroundStyle(vm.selectedRunUnit.color)
                    .symbolSize(80)
                    
                }
                .chartXAxis{
                    AxisMarks(values: .automatic) { value in
                        AxisGridLine()
                        AxisValueLabel{
                            if let date = value.as(Date.self) {
                                VStack(spacing: 0) {
                                    Text(date, format: .dateTime.day())
                                        .font(.footnote)
                                        .bold()
                                    if dynamicTypeSize <= .large{
                                        Text(date, format: .dateTime.month(.abbreviated))
                                            .font(.caption2)
                                            .textCase(.uppercase)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .offset(x: -12)
                            }
                        }
                    }
                }
                .chartYAxis{
                    AxisMarks(position: .leading) { value in
                        AxisGridLine()
                        AxisValueLabel {
                            if let val = value.as(Double.self) {
                                VStack{
                                    Text(vm.getValueForMetric(val))
                                        .font(.footnote)
                                        .bold()
                                    if dynamicTypeSize <= .large{
                                        Text(vm.selectedRunUnit.unit)
                                            .font(.caption2)
                                            .textCase(.uppercase)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        }
                    }
                }
                .chartYScale(domain: .automatic(includesZero: false, reversed: vm.selectedRunUnit == .pace))
                .frame(minHeight: 280)
                .padding(.vertical)
                
                
                //MARK: - Stats
                ViewThatFits{
                    HStack(spacing: 16){
                        statsView(
                            title: "Average",
                            value: vm.calculateAverage(for: runs),
                            icon: "chart.bar.fill"
                        )
                        statsView(
                            title: "Best",
                            value: vm.calculateBest(for: runs),
                            icon: "arrow.up.circle.fill"
                        )
                        statsView(
                            title: "Last",
                            value: vm.calculateLast(for: runs),
                            icon: "clock.fill"
                        )
                    }
                    
                    VStack(spacing: 16){
                        statsView(
                            title: "Average",
                            value: vm.calculateAverage(for: runs),
                            icon: "chart.bar.fill"
                        )
                        statsView(
                            title: "Best",
                            value: vm.calculateBest(for: runs),
                            icon: "arrow.up.circle.fill"
                        )
                        statsView(
                            title: "Last",
                            value: vm.calculateLast(for: runs),
                            icon: "clock.fill"
                        )
                    }
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(16)
            
            
            Spacer()
        }
    }
    
    
    //MARK: - Funcs
    @ViewBuilder
    func statsView(title: String, value: String, icon: String) -> some View {
        VStack(spacing: 8){
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(vm.selectedRunUnit.color)
            
            VStack(spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(value)
                    .font(.headline)
                Text(vm.selectedRunUnit.unit)
                    .font(.footnote)
                    .foregroundStyle(.tertiary)
                
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(vm.selectedRunUnit.color.opacity(0.1))
        .cornerRadius(12)
        .accessibilityElement(children: .combine)
    }
    
        
    
}

#Preview {
    GraphView()
}
