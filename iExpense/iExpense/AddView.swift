//
//  AddView.swift
//  iExpense
//
//  Created by Ian Huettel on 2/6/21.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var expenseName = ""
    @State private var expenseCost = ""
    @State private var expenseType = "Personal"
    @State private var isShowingAlert = false
    
    static var expenseTypes = ["Personal", "Business"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Expense", text: $expenseName)
                    .disableAutocorrection(true)
                TextField("$0.00", text: $expenseCost)
                    .keyboardType(.decimalPad)
                Picker("Type of Expense", selection: $expenseType) {
                    ForEach(Self.expenseTypes, id: \.self) {
                        Text($0)
                    }
                }
            }
            .navigationBarTitle("Add Expense", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                if let itemCost = Double(self.expenseCost) {
                    if expenseName.isEmpty {
                        expenseName = "Expense"
                    }
                    let item = ExpenseItem(name: expenseName, cost: itemCost, type: expenseType)
                    expenses.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                } else {
                    isShowingAlert = true
                }
            })
        }
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Error"), message: Text("Please enter a valid dollar amount for your expense."), dismissButton: .default(Text("Dismiss")))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
