//
//  ContentView.swift
//  LunchBot
//
//  Created by Peter Mihók on 08/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    let dishes: [Dish] = [
        .init(name: "1. Hot dish", imageName: "Chicken", seed: nil, settings: nil),
        .init(name: "2. Side dish", imageName: "PastaButBigger", seed: nil, settings: .init(padding: 10, offsetX: 10, offsetY: 10, angle: 30, rows: 7, columns: 6)),
        .init(name: "3. Salad", imageName: "Salad", seed: nil, settings: .init(padding: 10, offsetX: 10, offsetY: 10, angle: 30, rows: 7, columns: 6)),
        .init(name: "4. Bread & Toppings", imageName: "Toppings", seed: 1, settings: .init(padding: 3, offsetX: -10, offsetY: -30, angle: 10, rows: 6, columns: 5)),
    ].sorted(by: <)
    
    @State private var tabSelection = 0
    @State var results: [Dish: Double] = [:]
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ForEach(0 ..< dishes.count, id: \.self) { index in
                DishView(dish: dishes[index]) { percentageUnused in
                    results[dishes[index]] = percentageUnused
                    withAnimation {
                        tabSelection += 1
                    }
                }
                .onAppear {
                    results[dishes[index]] = 0
                }
                .padding()
                .tag(index)
            }
            
            SummaryView(results: $results) {
                save(results: results)
            } restartPressed: {
                results.removeAll()
                withAnimation {
                    tabSelection = 0
                }
            } sharePressed: {
                shareButton()
            }
            .tag(dishes.count)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
    
    func shareButton() {
        let shareable = results.map { dish, result in
            "\(dish.name) -> \(Int(result * 100.0))%"
        }.joined(separator: "\n")
        
        
        let activityController = UIActivityViewController(activityItems: [shareable], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
    
    struct DishResult: Codable {
        let dishName: String
        let result: Double
    }
    
    struct SummaryResult: Codable {
        let dishResults: [DishResult]
        let date: Date
    }
    
    private func save(results: [Dish: Double]) {
        
        var saveData: [String: SummaryResult] = [:]
        if let data = UserDefaults.standard.value(forKey: "summaries"), let savedData = try? JSONDecoder().decode([String: SummaryResult].self, from: data as! Data) {
            saveData = savedData
        }
        
        let dishResults = results.map {
            DishResult(dishName: $0.name, result: $1)
        }
        
        let summary = SummaryResult(dishResults: dishResults, date: Date())
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let key = dateFormatter.string(from: Date())

        saveData[key] = summary
        
        print(saveData)
        
        if let data = try? JSONEncoder().encode(saveData) {
            UserDefaults.standard.set(data, forKey: "summaries")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

