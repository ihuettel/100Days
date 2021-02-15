//
//  ContentView.swift
//  iExpense
//
//  Created by Ian Huettel on 1/24/21.
//

import SwiftUI

struct colorCost: ViewModifier {
    var cost: Double
    var params: (dollarSigns: String, color: Color) {
        if cost < 10.0 {
            return ("$", .green)
        } else if cost < 100.0 {
            return ("$$", .orange)
        } else {
            return ("$$$", .red)
        }
    }
    
    func body(content: Content) -> some View {
        HStack {
            Text(params.dollarSigns)
                .fontWeight(.bold)
                .foregroundColor(params.color)
            content
        }
    }
}

extension View {
    func colorCodedText(for cost: Double) -> some View {
        self.modifier(colorCost(cost: cost))
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var cost: Double
    var type: String
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    
    init() {
        if let loaded = UserDefaults.standard.data(forKey: "items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([ExpenseItem].self, from: loaded) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    func removeExpense(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    VStack(alignment: .trailing) {
                        HStack {
                            Text("\(item.name)")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                            Text("$\(item.cost, specifier: "%.2f")")
                                .colorCodedText(for: item.cost)
                        }
                        Text("\(item.type)")
                    }
                }
                .onDelete(perform: removeExpense)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing:
                                    Button(action: {
                                        showingAddExpense = true
                                    }) {
                                        Image(systemName: "plus")
                                    })
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
