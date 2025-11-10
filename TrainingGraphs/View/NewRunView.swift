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
                .foregroundStyle(.opacity(0.5))
                .padding()

                Form{
                    Section("Date") {
                        //                    DatePicker("Select a Date", selection: $date)
                        //                        .labelsHidden()
                        HStack{
                            
                            Button{
                                isPickerDatePresented = true
                            } label: {
                                Text(date, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
                                //                            Text(date.formatted())
                            }
                            .sheet(isPresented: $isPickerDatePresented) {
                                DatePicker("Select a Date", selection: $date)
                                    .labelsHidden()
                                    .datePickerStyle(.wheel)
                                    .presentationDetents([
                                        .height(200)
                                    ])
                            }
                            
                            
                            Spacer()
                            Image(systemName: "chevron.down")
                        }
                    }
                    
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
                                            Text("\(hour)h").tag(Double(hour))
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                    
                                    Picker("Minutes", selection: $minutes) {
                                        ForEach(0..<60, id: \.self) { min in
                                            Text("\(min)m").tag(Double(min))
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                    
                                }
                                .presentationDetents([
                                    .height(200)
                                ])
                            }
                            Spacer()
                            Image(systemName: "chevron.down")
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
                                            .tag(Double(kms))
                                    }
                                }
                                .pickerStyle(.wheel)
                                .presentationDetents([
                                    .height(200)
                                ])
                            }
                            
                            Spacer()
                            Image(systemName: "chevron.down")
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
                    }
                    
                    
                    HStack{
                        Spacer()
                        Button{
                            
                            context.insert(
                                Run(
                                    date: date,
                                    durationMin: Int(durationMin),
                                    distanceKm: distanceKm
                                )
                            )
                            
                            // Salvar explicitamente
                            do {
                                try context.save()
                            } catch {
                                print("Erro ao salvar: \(error)")
                            }
                            
                            // Limpar os campos
                            date = Date()
                            
                            minutes = 0
                            hours = 0
                            
                            distanceKm = 0
                            
                            // Mostrar confirmação
                            showConfirmDialog = true
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
}

#Preview {
    NewRunView()
    
}


