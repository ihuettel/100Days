//
//  ContentView.swift
//  ProductFarms
//
//  Created by Ian Huettel on 1/19/21.
//

import SwiftUI

enum bgColor {
    case black
    case white
    case blue
}

struct ContentView: View {
    @State private var backgroundSlider = bgColor.black
    var body: some View {
        switch backgroundSlider {
        case .black:
            return Color.black
        case .white:
            return Color.white
        case .blue:
            return Color.blue
        }
        
        Slider(value: $backgroundSlider, in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
