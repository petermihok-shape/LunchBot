//
//  SliderView.swift
//  LunchBot
//
//  Created by Jonatan Nielavitzky on 09/09/2022.
//

import SwiftUI

struct SliderView: View {
    
    var body: some View {
        Text("🔪")
            .font(.system(size: 150))
            .rotationEffect(.degrees(-45))
            .rotation3DEffect(.degrees(180), axis: (0, 1, 0))
            .offset(x: 65, y: -95)
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView()
    }
}
