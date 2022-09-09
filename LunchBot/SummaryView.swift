//
//  SummaryView.swift
//  LunchBot
//
//  Created by Peter Mihók on 08/09/2022.
//

import SwiftUI

struct SummaryView: View {
    
    @Binding var results: [Dish: Double]
    @State var saved: Bool = false
    let savePressed: () -> Void
    let restartPressed: () -> Void
    let sharePressed: () -> Void
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("You are done!")
                .font(.title)
                .padding()
            
            Text("Percentage used:")
                .font(.title2)
                .padding()
            
            Spacer()
            
            ForEach(results.sorted(by: <), id: \.key) { dish, result in
                HStack {
                    Text("\(dish.name):")
                    Spacer()
                    Text("\(Int(result * 100))%")
                }
                .padding(.vertical, 1)
                .padding(.horizontal, 50)
            }
            
            Spacer()
            
            if !saved {
                Button {
                    savePressed()
                    saved = true
                } label: {
                    Text("Save")
                        .font(.system(size: 20))
                        .frame(width: 200, height: 50)
                }
                .buttonStyle(.bordered)
                .padding(.top, 30)
            } else {
                Button {
                    sharePressed()
                } label: {
                    Text("Share")
                        .font(.system(size: 20))
                        .frame(width: 200, height: 50)
                }
                .buttonStyle(.bordered)
                .padding(.top, 30)
            }
            
            
            Button {
                restartPressed()
            } label: {
                Text("Restart")
                    .font(.system(size: 20))
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(.bordered)

            Spacer()
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(results: .constant([Dish(name: "Apple", imageName: "Chicken", seed: 0.1, settings: nil) : 0.5]), savePressed: {}, restartPressed: {}, sharePressed: {})
    }
}
