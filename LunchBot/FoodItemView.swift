//
//  FoodItemView.swift
//  LunchBot
//
//  Created by Peter Mihók on 08/09/2022.
//

import SwiftUI

struct FoodItemView: View {
    
    let foodItem: FoodItem
    
    var body: some View {
        Text(foodItem.emoji)
            .font(.system(size: 500))
            .minimumScaleFactor(0.01)
            .shadow(color: .black.opacity(0.2), radius: 10, x: foodItem.seed * 10, y: foodItem.seed * 10)
            .offset(x: foodItem.seed * 2.5, y: foodItem.seed * 2.5)
            .rotation3DEffect(.degrees(foodItem.seed * 30), axis: (1, 1, 1))
            
    }
}

struct FoodItem: Identifiable {
    let id = UUID()
    let emoji: String
    let seed: Double
}

struct FoodItem_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemView(foodItem: .init(emoji: "🍏", seed: 0.5))
            .frame(width: 200, height: 200)
    }
}
