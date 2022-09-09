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
        Image(uiImage: UIImage(named: foodItem.imageName)!)
            .resizable()
            .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
            .offset(x: foodItem.seed * (foodItem.settings?.offsetX ?? 2.5), y: foodItem.seed * (foodItem.settings?.offsetY ?? 2.5))
            .rotationEffect(.degrees(foodItem.seed * (foodItem.settings?.angle ?? 15)))
            
    }
}

struct FoodItem: Identifiable {
    let id = UUID()
    let imageName: String
    let seed: Double
    let settings: DishPositioningSettings?
}

struct FoodItem_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemView(foodItem: .init(imageName: "case", seed: 0.5, settings: nil))
            .frame(width: 200, height: 200)
    }
}
