//
//  DishView.swift
//  LunchBot
//
//  Created by Peter Mihók on 08/09/2022.
//

import SwiftUI

struct DishView: View {
    
    let dish: Dish
    @State private var percentageUnused = 0.0
    let pressed: (Double) -> Void
    let foodItems = FoodItems()
    
    var body: some View {
        VStack {
            Text(dish.name)
                .font(.title)
            
            Spacer()
            
            TraySliderView(foodItems: foodItems.set(dish: dish), percentageUnused: $percentageUnused)
            
            Spacer()
            
            Button {
                pressed(percentageUnused)
            } label: {
                Text(percentageUnused.emoji)
                    .font(.system(size: 50))
                    .frame(width: 200, height: 50)
            }
            .buttonStyle(.bordered)
            .padding(30)
        }
    }
}

class FoodItems {
    var foodItems: [FoodItem]? = nil
    func set(dish: Dish) -> [FoodItem] {
        guard foodItems == nil else { return foodItems! }
        foodItems = (0 ..< 50).map { _ in
            FoodItem(emoji: dish.emoji, seed: Double.random(in: -1...1))
        }
        
        return foodItems!
    }
}

struct Dish: Hashable, Comparable {
    let name: String
    let emoji: String
    
    static func < (lhs: Dish, rhs: Dish) -> Bool {
        lhs.name < rhs.name
    }
}

private extension Double {
    var emoji: String {
        switch self {
        case 0.0 ..< 0.1:
            return "🤬"
        case 0.1 ..< 0.5:
            return "😡"
        case 0.5 ..< 0.75:
            return "🫤"
        case 0.75 ..< 0.99:
            return "😀"
        case 0.99 ... 1.0:
            return "🥳"
        default:
            return "🧐"
        }
    }
}

struct DishView_Previews: PreviewProvider {
    static var previews: some View {
        DishView(dish: .init(name: "Hot dog", emoji: "🌭"), pressed: { _ in })
            .padding(50)
    }
}
