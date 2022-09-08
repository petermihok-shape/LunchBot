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
    
    var body: some View {
        ZStack(alignment: .top) {            
            Color.gray
                .contentShape(Rectangle())
                .frame(width: 200, height: 300)
                .border(Color.black, width: 2)
                .offset(y: 10)
            VStack(spacing: 0) {
                ForEach(0 ..< 10, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0 ..< 5, id: \.self) { column in
                            FoodItemView(foodItem: foodItems[row * 5 + column])
                                .frame(width: 50, height: 50)
                                .padding(-10)
                                .opacity(row > Int((draggedOffset / 300.0) * 10) ? 1.0 : 0.0)
                        }
                    }
                }
            }
            Text("🔪")
                .font(.system(size: 150))
                .rotationEffect(.degrees(-45))
                .rotation3DEffect(.degrees(180), axis: (0, 1, 0))
                .offset(x: 65, y: -95 + draggedOffset)
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged { drag in
                            let yDragged = drag.location.y
                            draggedOffset = max(min(yDragged, 300), 0)
                            percentageUnused = draggedOffset / 300.0
                        }
                )
            
        }
        .rotation3DEffect(.degrees(20), axis: (1, 0, 0))
    }
}

struct TraySlider_Previews: PreviewProvider {
    static var previews: some View {
        let foodItems = (0 ..< 50).map { _ in FoodItem(emoji: "🍕",seed: Double.random(in: -1...1)) }
        TraySliderView(foodItems: foodItems, percentageUnused: .constant(0.5))
            .padding()
    }
}
