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
    @State private var dismissTray = false
    let pressed: (Double) -> Void
    let foodItems = FoodItems()
    
    var body: some View {
        VStack {
            Text(dish.name)
                .font(.title)
            
            Spacer()
            
            TraySliderView(foodItems: foodItems.set(dish: dish), percentageUnused: $percentageUnused, dismiss: $dismissTray)
            
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
            FoodItem(imageName: dish.imageName, seed: dish.seed ?? Double.random(in: -1...1), settings: dish.settings)
        }
        
        return foodItems!
    }
}

struct Dish: Hashable, Comparable {
    let name: String
    let imageName: String
    let seed: Double?
    let settings: DishPositioningSettings?
    
    static func < (lhs: Dish, rhs: Dish) -> Bool {
        lhs.name < rhs.name
    }
    
    static func == (lhs: Dish, rhs: Dish) -> Bool {
        lhs.name == rhs.name
    }
}

struct DishPositioningSettings: Hashable {
    let padding: Double
    let offsetX: Double
    let offsetY: Double
    let angle: Double
    let rows: Int
    let columns: Int
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
        DishView(dish: .init(name: "Hot dog", imageName: "case", seed: 0.0, settings: nil), pressed: { _ in })
            .padding(50)
    }
}
