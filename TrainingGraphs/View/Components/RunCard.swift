//
//  RunCard.swift
//  TrainingGraphs
//
//  Created by Eduardo Bertol on 04/11/25.
//

import SwiftUI

struct RunCard: View {
    
    @State var date: Date = Date()
    @State var durationMin: Int
    @State var distanceKm: Double
    @State var pace: Double
    
    var body: some View {
//        ZStack{
            HStack(spacing: 8){
                Spacer()
                
                Text("\(distanceKm.format2F()) Km")
                    .font(.title)
                    .bold()
                
                Spacer()
                
                Text("\(durationMin) min")
                    .font(.title2)

                Spacer()
                
                VStack(alignment: .leading){
                    Text("\(pace.format2F()) min/Km")
                        .font(.footnote)
                    Spacer()
                    Text(date, format: Date.FormatStyle(date: .numeric))
                        .font(.footnote)
                }
            }
            .frame(maxHeight: 75)
//            .padding(8)
//            .background(Color(.systemGray5))
//            .padding(.horizontal, 8)
            
//            HStack{
//                Spacer()
//                VStack{
//                    Circle()
//                        .frame(height: 13)
//                    Spacer()
//                    Circle()
//                        .frame(height: 13)
//                }
//                .frame(maxHeight: 100)
//                .foregroundStyle(.white)
//                Spacer()
//            }
//            
//        }
    }
}

#Preview {
//    RunCard(date: .constant(Date()), durationMin: .constant(20), distanceKm: .constant(3))
    RunCard(date: Date(), durationMin: 20, distanceKm: 3, pace: 5.5)
}
