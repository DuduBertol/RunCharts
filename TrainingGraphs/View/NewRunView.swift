//
//  NewTrain.swift
//  TrainingGraphs
//
//  Created by Eduardo Bertol on 29/10/25.
//

import SwiftUI
import SwiftData

struct NewRunView: View {
    @Environment(\.modelContext) private var context
    
    @State var date: Date = Date()
    
    @State var minutes: Double = 0
    @State var hours: Double = 0
    var durationMin: Double {
        (hours * 60) + minutes
    }
    
    @State var distanceKm: Double = 0
    
    @State var isPickerDatePresented: Bool = false
    @State var isPickerDurationPresented: Bool = false
    @State var isPickerDistancePresented: Bool = false
    let fractionalDistances = Array(stride(from: 0.0, through: 100.0, by: 0.25))
    
    @State var showConfirmDialog: Bool = false
    var cannotCreateNewRun: Bool {
        durationMin <= 0 || distanceKm <= 0
    }
    
    var body: some View {
        VStack(spacing: 16){
            Text("New")
                .font(.title)
                .bold()
                .foregroundStyle(.secondary)
                .padding()
            
            Form{
                Section("Date") {
                    HStack{
                        
                        Button{
                            isPickerDatePresented = true
                        } label: {
                            Text(date, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
                        }
//                        .accessibilityLabel("Date") // É
//                        .accessibilityValue(Text(date, format: Date.FormatStyle(date: .long, time: .shortened))) //VALOR
//                        .accessibilityHint("Double tap to select a new date") //FAZ
                        
                        .sheet(isPresented: $isPickerDatePresented) {
                            DatePicker("Select a Date", selection: $date)
                            //                                    .font(.body)
                                .labelsHidden()
                                .datePickerStyle(.wheel)
                                .presentationDetents([
                                    .height(200)
                                ])
                        }
                        
                        Spacer()
                        Image(systemName: "chevron.down")
                            .accessibilityHidden(true)
                    }
                }
//                .accessibilityHint("Select the date of your Run")
//                .accessibilityElement(children: .combine)
                
                
                Section("Duration") {
                    HStack{
                        Button{
                            isPickerDurationPresented = true
                        } label: {
                            Text("\(durationMin.formatTimeHourMin())")
                        }
                        .sheet(isPresented: $isPickerDurationPresented) {
                            
                            HStack{
                                Picker("Hours", selection: $hours) {
                                    ForEach(0..<25, id: \.self) { hour in
                                        Text("\(hour)h")
                                            .font(.body)
                                            .tag(Double(hour))
                                    }
                                }
                                .pickerStyle(.wheel)
                                
                                Picker("Minutes", selection: $minutes) {
                                    ForEach(0..<60, id: \.self) { min in
                                        Text("\(min)m")
                                            .font(.body)
                                            .tag(Double(min))
                                    }
                                }
                                .pickerStyle(.wheel)
                                
                            }
                            .presentationDetents([
                                .height(200)
                            ])
                        }
                        .accessibilityLabel { label in
                            if durationMin == 0 {
                                Text("Empty Duration")
                            }
                            label
                        }
                        
                        Spacer()
                        Image(systemName: "chevron.down")
                            .accessibilityHidden(true)
                    }
                }
                
                Section("Distance") {
                    HStack{
                        Button{
                            isPickerDistancePresented = true
                        } label: {
                            Text(String(format: "%.2f km", distanceKm))
                        }
                        .sheet(isPresented: $isPickerDistancePresented) {
                            Picker("Set Distance (km)", selection: $distanceKm) {
                                ForEach(fractionalDistances, id: \.self) { kms in
                                    Text(String(format: "%.2f km", kms))
                                        .font(.body)
                                        .tag(Double(kms))
                                }
                            }
                            .pickerStyle(.wheel)
                            .presentationDetents([
                                .height(200)
                            ])
                        }
                        .accessibilityLabel { label in
                            if distanceKm == 0 {
                                Text("Empty Distance")
                            }
                            label
                        }
                        
                        Spacer()
                        Image(systemName: "chevron.down")
                            .accessibilityHidden(true)
                    }
                    
                }
                
                
                
                Section("Total Run Data"){
                    VStack(alignment: .leading){
                        Text("**\(String(format: "%.2f", distanceKm))** km")
                            .font(.title)
                        Text("\(durationMin.formatTimeHourMin())\n")
                            .font(.title)
                        Text(date, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
                    }
                    .accessibilityElement(children: .combine)
                }
                
                
                HStack{
                    Spacer()
                    Button{
                        addNewRun(Run(
                            date: date,
                            durationMin: Int(durationMin),
                            distanceKm: distanceKm
                        ))
                        
                    } label: {
                        Text("Create New Run")
                    }
                    .disabled(cannotCreateNewRun)
                    .alert("Successfully Created Run!", isPresented: $showConfirmDialog) {}
                    
                    Spacer()
                }
            }
            //                .scrollContentBackground(.hidden)
        }
        .background()
    }
    
    //MARK: - Funcs
    private func addNewRun(_ run: Run){
        context.insert(run)
        
        do {
            try context.save()
        } catch {
            print("Erro ao salvar: \(error)")
            return
        }
        
        clearRunFields()
        showConfirmDialog = true
    }
    
    private func clearRunFields() {
        date = Date()
        minutes = 0
        hours = 0
        distanceKm = 0
    }
}

#Preview {
    NewRunView()
    
}


