//
//  ContentView.swift
//  WeConvert
//
//  Created by homebase on 1/8/21.
//

import SwiftUI

struct ContentView: View {
    @State private var temperature = ""
    @State private var inputTemperature = 0
    @State private var outputTemperature = 2
    
    private var temperatureUnits = ["ºF", "K", "ºC"]
    private var resultTemperature: Double {
        guard let temp = Double(temperature) else {
            return 0
        }
        if inputTemperature == outputTemperature {
            return temp
        }
        
        let tempUnit: Measurement<UnitTemperature>
        switch inputTemperature {
        case 0:
            tempUnit = Measurement(value: temp, unit: UnitTemperature.fahrenheit)
        case 1:
            tempUnit = Measurement(value: temp, unit: UnitTemperature.kelvin)
        default:
            tempUnit = Measurement(value: temp, unit: UnitTemperature.celsius)
        }
        
        switch outputTemperature {
        case 0:
            return tempUnit.converted(to: UnitTemperature.fahrenheit).value
        case 1:
            return tempUnit.converted(to: UnitTemperature.kelvin).value
        default:
            return tempUnit.converted(to: UnitTemperature.celsius).value
        }
    }
    
    @State private var length = ""
    @State private var inputLength = 0
    @State private var outputLength = 5
    
    private var lengthUnits = ["Inches", "Feet", "Yards", "Miles", "Milimeters", "Centimeters", "Meters", "Kilometers"]
    private var resultLength: String {
        // Using guard let here let's us avoid providing a default output..
        // ..since nothing is a better conversion of "asdf" than "0 meters"
        // (in my current opinion)
        guard let len = Double(length) else {
            return ""
        }
        
        let lenUnit: Measurement<UnitLength>
        switch inputLength {
        case 0:
            lenUnit = Measurement(value: len, unit: UnitLength.inches)
        case 1:
            lenUnit = Measurement(value: len, unit: UnitLength.feet)
        case 2:
            lenUnit = Measurement(value: len, unit: UnitLength.yards)
        case 3:
            lenUnit = Measurement(value: len, unit: UnitLength.miles)
        case 4:
            lenUnit = Measurement(value: len, unit: UnitLength.millimeters)
        case 5:
            lenUnit = Measurement(value: len, unit: UnitLength.centimeters)
        case 6:
            lenUnit = Measurement(value: len, unit: UnitLength.meters)
        default:
            lenUnit = Measurement(value: len, unit: UnitLength.kilometers)
        }
        
        switch outputLength {
        case 0:
            return lenUnit.converted(to: UnitLength.inches).description
        case 1:
            return lenUnit.converted(to: UnitLength.feet).description
        case 2:
            return lenUnit.converted(to: UnitLength.yards).description
        case 3:
            return lenUnit.converted(to: UnitLength.miles).description
        case 4:
            return lenUnit.converted(to: UnitLength.millimeters).description
        case 5:
            return lenUnit.converted(to: UnitLength.centimeters).description
        case 6:
            return lenUnit.converted(to: UnitLength.meters).description
        default:
            return lenUnit.converted(to: UnitLength.kilometers).description
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Temperature conversion")) {
                    Picker("Starting temperature unit", selection: $inputTemperature) {
                        ForEach(0 ..< temperatureUnits.count) {
                            Text("\(temperatureUnits[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    TextField("Temperature", text: $temperature)
                        .keyboardType(.decimalPad)
                    
                    Picker("Converted temperature unit", selection: $outputTemperature) {
                        ForEach(0 ..< temperatureUnits.count) {
                            Text("\(temperatureUnits[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Text("\(resultTemperature, specifier: "%.1f") \(temperatureUnits[outputTemperature])")
                }
                
                // Handles all the UI for length conversion
                Section(header: Text("Length conversion")) { // Create the section and give it a visible name
                    
                    // Set the default text & variable for the starting length picker
                    Picker("Convert length in", selection: $inputLength) {
                        ForEach(0 ..< lengthUnits.count) { // Iterate through all the available units..
                            Text("\(lengthUnits[$0])") // ..and make them into a list.
                        }
                    }
                    
                    // Make a (poorly validated) text field for input
                    TextField("Length / Distance", text: $length)
                        .keyboardType(.decimalPad) // Restrict it to the decimal number pad
                    // This doesn't prevent pasting or typing from an external keyboard though
                    
                    // Set the default text & variable for the type to convert to
                    Picker("To length in", selection: $outputLength) {
                        ForEach(0 ..< lengthUnits.count) { // Iterate through all available units..
                            Text("\(lengthUnits[$0])") // ..and make them into a list.
                        }
                    }

                    //Text("\(resultLength, specifier: "%.2f") \(lengthUnits[outputLength])")
                    Text("\(resultLength)") // Uses the native .description of Measurement Unit types to provide an output string
                    // Doesn't provide super clean formatting for long decimals though
                    // Possibly an improvement in the future.
                }
                
                // I will come back to these if I have the time or motivation
                Section(header: Text("Time conversion")) {
                    Text("Time conversion")
                }
                
                Section(header: Text("Volume conversion")) {
                    Text("Volume conversion")
                }
            }
            .navigationBarTitle(Text("WeConvert"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
