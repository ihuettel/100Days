//
//  ContentView.swift
//  BetterRest
//
//  Created by Ian Huettel on 1/14/21.
//

import SwiftUI

struct ContentView: View {
    
    static var defaultWakeupTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    @State private var wakeupTime = defaultWakeupTime
    @State private var hoursOfSleep = 8.0
    @State private var cupsOfCoffee = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertShowing = false
    
    
    func calculateBedtime() {
        
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeupTime)
        let hours = (components.hour ?? 0) * 60 * 60
        let minutes = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hours + minutes), estimatedSleep: hoursOfSleep, coffee: Double(cupsOfCoffee))
            let sleepTime = wakeupTime - prediction.actualSleep
            let formatter = DateFormatter()
            
            formatter.timeStyle = .short
            alertTitle = "Your ideal bedtime is..."
            alertMessage = formatter.string(from: sleepTime)
        } catch {
            alertTitle = "Error"
            alertMessage = "Unknown error occured while getting your bedtime."
        }
        
        alertShowing = true
    }
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text("What time do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please choose a wakeup time.", selection: $wakeupTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("How long do you want to sleep for?")
                        .font(.headline)
                    
                    Stepper(value: $hoursOfSleep, in: 4 ... 12, step: 0.25) {
                        Text("\(hoursOfSleep, specifier: "%g") hours")
                    }
                        .accessibilityIdentifier("hours")
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    
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
            .alert(isPresented: $alertShowing) {
                Alert(title: Text(alertTitle),
                      message: Text(alertMessage),
                      dismissButton: .default(Text("Dismiss"))
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
