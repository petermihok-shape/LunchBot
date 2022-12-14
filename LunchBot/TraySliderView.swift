//
//  TraySliderView.swift
//  LunchBot
//
//  Created by Peter Mihók on 08/09/2022.
//

import SwiftUI

struct TraySliderView: View {
    
    let foodItems: [FoodItem]
    @State private var draggedOffset = 0.0
    @Binding var percentageUnused: Double
    @Binding var dismiss: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            Image(uiImage: UIImage(named: "TrayBack")!)
                .resizable()
                .frame(width: 290, height: 290)
            
            let settings = foodItems.first?.settings
            let rows = settings?.rows ?? 7
            let columns = settings?.columns ?? 6
            let padding = Double(settings?.padding ?? 10) * -1.0
            
            VStack(spacing: 0) {
                ForEach(0 ..< rows, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0 ..< columns, id: \.self) { column in
                            FoodItemView(foodItem: foodItems[row * columns + column])
                                .frame(width: 50, height: 50)
                                .padding(padding)
                                .opacity(row + 1 > Int((draggedOffset.toPercentage(height: 185)) * Double(rows)) ? 1.0 : 0.0)
                        }
                    }
                }
            }
            .rotation3DEffect(.degrees(20), axis: (1, 0, 0))
            
            
            ZStack {
                Image(uiImage: UIImage(named: "TrayFront")!)
                    .resizable()
                .frame(width: 290, height: 290)
                
                Text("\(Int(draggedOffset.toPercentage(height: 185.0)*100))%")
                    .font(.title)
                    .offset(x: 0.0, y: 190.0)
            }
            
            
            SliderView()
                .offset(y: draggedOffset)
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged { drag in
                            let yDragged = drag.location.y
                            draggedOffset = max(min(yDragged, 185), 0)
                            percentageUnused = draggedOffset.toPercentage(height: 185)
                        }
                )
                .rotation3DEffect(.degrees(10), axis: (1, 0, 0))
        }
    }
}

extension Double {
    func toPercentage(height: Double) -> Double {
        self / height
    }
}

struct TraySlider_Previews: PreviewProvider {
    static var previews: some View {
        let foodItems = (0 ..< 50).map { _ in FoodItem(imageName: "Chicken", seed: Double.random(in: -1...1), settings: nil) }
        TraySliderView(foodItems: foodItems, percentageUnused: .constant(0.5), dismiss: .constant(false))
            .padding()
    }
}
