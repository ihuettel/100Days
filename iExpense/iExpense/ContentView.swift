//
//  ContentView.swift
//  iExpense
//
//  Created by Ian Huettel on 1/24/21.
//

import SwiftUI

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
                    //Text("\(item.name), $\(item.cost, specifier: "%.2f") - \(item.type)")
                    VStack(alignment: .trailing) {
                        HStack {
                            Text("\(item.name)")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                            Text("$\(item.cost, specifier: "%.2f")")
                        }
                        Text("\(item.type)")
                    }
                }
                .onDelete(perform: removeExpense)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
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
