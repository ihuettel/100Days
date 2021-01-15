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
    
    func calculateBedtime() -> String {
        
        let model = SleepCalculator()
        var components = Calendar.current.dateComponents([.hour, .minute], from: wakeupTime)
        let hours = (components.hour ?? 0) * 60 * 60
        let minutes = (components.minute ?? 0) * 60
        let sleepTime: Date
        
        do {
            let prediction = try model.prediction(wake: Double(hours + minutes), estimatedSleep: hoursOfSleep, coffee: Double(cupsOfCoffee))
            sleepTime = wakeupTime - prediction.actualSleep
        } catch {
            components.hour = (components.hour ?? 7) - Int(hoursOfSleep)
            sleepTime = Calendar.current.date(from: components) ?? Date()
        }
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        return formatter.string(from: sleepTime)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("What time do you want to wake up?")) {
                    
                    DatePicker("Please choose a wakeup time.", selection: $wakeupTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("How long do you want to sleep for?")) {
                    
                    Stepper(value: $hoursOfSleep, in: 4 ... 12, step: 0.25) {
                        Text("\(hoursOfSleep, specifier: "%g") hours")
                    }
                    .accessibilityIdentifier("hours")
                }
                
                Section(header: Text("How many cups of coffee will you be having?")) {
                    Picker("How many cups of coffee will you be having?", selection: $cupsOfCoffee) {
                        ForEach(0 ..< 21) {
                            Text("\($0) \($0 == 1 ? "cup" : "cups")")
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(DefaultPickerStyle())
                    .accessibilityIdentifier("coffee")
                }
                
                Section(header: Text("Your ideal bedtime time")) {
                    Text("\(calculateBedtime())")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
//
//  I'm leaving this code in as per a comment left in the tests.
//  This was my solution to fixing the accessibilityIndentifier not being read.
//  ..I don't know exactly why it worked, but I'd put money on the ternary operator
//  letting me use a single text field as opposed to writing 2 text fields and using
//  a conditional block to determine which gets used.
//
//  All of this has been replaced by the picker implemented above as part of a challenge.
                
//                    Stepper(value: $cupsOfCoffee, in: 0 ... 20) {
//                        Text("\(cupsOfCoffee) \(cupsOfCoffee == 1 ? "cup" : "cups") of coffee")
//                    }
//                        .accessibilityIdentifier("coffee")
//
            }
            .navigationBarTitle("Better Rest")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
