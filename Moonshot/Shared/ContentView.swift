//
//  ContentView.swift
//  Shared
//
//  Created by Ian Huettel on 2/16/21.
//

import SwiftUI

struct ContentView: View {
    private var astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        Text("\(astronauts.count)")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
