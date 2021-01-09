//
//  ContentView.swift
//  WeSplit
//
//  Created by homebase on 1/8/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    /*
    func calculateSplit() -> String {
        var split: Double = Double(checkAmount) ?? 0
        split *= 1.0 + Double(tipPercentages[tipPercentage]) / 100
        split /= Double(numberOfPeople + 2)
        return String(split)
    } */
    
    
    var total: (allTogether: Double, perPerson: Double) {
        let peopleCount = Double(numberOfPeople) ?? 1.0
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let allTogether = orderAmount + (orderAmount * tipSelection / 100)
        let perPerson = allTogether / peopleCount

        return (allTogether, perPerson)
    }
    
    var body: some View {
        NavigationView {
            
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(total.perPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Total with tip")) {
                    Text("$\(total.allTogether, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}