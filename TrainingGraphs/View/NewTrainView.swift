//
//  NewTrain.swift
//  TrainingGraphs
//
//  Created by Eduardo Bertol on 29/10/25.
//

import SwiftUI
import SwiftData

struct NewTrainView: View {
    @Environment(\.modelContext) private var context
    
//    @StateObject var vm = NewTrainViewModel()
    
    @State var date: Date = Date()
    @State var durationMin: Double = 0
    @State var distanceKm: Double = 0

    @State var isPickerDatePresented: Bool = false
    @State var isPickerDurationPresented: Bool = false
    @State var isPickerDistancePresented: Bool = false
    let fractionalDistances = Array(stride(from: 0.0, through: 100.0, by: 0.25))
    
    @State var showConfirmDialog: Bool = false
    
    
    
    var body: some View {
        
        NavigationStack{
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
                
                Section("Duration (min)") {
                    HStack{
                        Button{
                            isPickerDurationPresented = true
                        } label: {
                            Text("\(durationMin.formatTime()) min")
                        }
                        .sheet(isPresented: $isPickerDurationPresented) {
                            Picker("Set Distance (km)", selection: $durationMin) {
                                ForEach(0..<501, id: \.self) { min in
                                    Text("\(min) min").tag(Double(min))
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
                
                Section("Distance (km)") {
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
                                .height(150)
                            ])
                        }
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                }
                
                
                
                Section("Run Data"){
                    VStack(alignment: .leading){
                        Text("**\(String(format: "%.2f", distanceKm))** km")
                            .font(.title)
                        Text("**\(durationMin.formatTime())** min\n")
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
                         durationMin = 0
                         distanceKm = 0
                         
                         // Mostrar confirmação
                         showConfirmDialog = true
                    } label: {
                        Text("Create New Run")
                    }
                    .alert("Successfully Created Run!", isPresented: $showConfirmDialog) {}
                    
                    Spacer()
                }
            }
            .navigationTitle("Create New Run")
        }
    }
}

#Preview {
    NewTrainView()
}


