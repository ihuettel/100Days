//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by homebase on 1/12/21.
//

import SwiftUI

struct ContentView: View {
    @State private var useRedText = false
    
    var body: some View {
        
        VStack {
                Button("Change color") {
                self.useRedText.toggle()
            }
            .foregroundColor(useRedText ? .red : .green)
            
            Text("Hello World!")
                .foregroundColor(useRedText ? .red : .green)
                
        }
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
