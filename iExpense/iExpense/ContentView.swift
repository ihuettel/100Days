//
//  ContentView.swift
//  iExpense
//
//  Created by Ian Huettel on 1/24/21.
//

import SwiftUI

struct ExpenseItem {
    var name: String
    var cost: Double
    var isForBusiness = false
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    
    func removeExpense(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items, id: \.name) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeExpense)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing: Button(action: {
                let expense = ExpenseItem(name: "Test", cost: 10)
                self.expenses.items.append(expense)
            }) {
                Image(systemName: "plus")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
