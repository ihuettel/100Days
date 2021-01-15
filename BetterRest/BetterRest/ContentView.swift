//
//  ContentView.swift
//  BetterRest
//
//  Created by Ian Huettel on 1/14/21.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeupTime = Date()
    @State private var hoursOfSleep = 8.0
    @State private var cupsOfCoffee = 1
    
    func calculateBedtime() {
        // More to come..
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("What time do you want to wake up?")
                    .font(.headline)
                
                DatePicker("Please choose a wakeup time.", selection: $wakeupTime, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                
                Text("How long do you want to sleep for?")
                    .font(.headline)
                
                Stepper(value: $hoursOfSleep, in: 4 ... 12, step: 0.25) {
                    Text("\(hoursOfSleep, specifier: "%g") hours")
                }
                    .accessibilityIdentifier("hours")
                Text("How much coffee will you be drinking?")
                    .font(.headline)
                
                Stepper(value: $cupsOfCoffee, in: 0 ... 20) {
                    if cupsOfCoffee == 1 {
                        Text("1 cup of coffee")
                    } else {
                        Text("\(cupsOfCoffee) cups of coffee")
                    }
                }
                .accessibilityIdentifier("coffee")
            }
            .navigationBarTitle("Better Rest")
            .navigationBarItems(trailing: Button("Calculate", action: calculateBedtime))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
