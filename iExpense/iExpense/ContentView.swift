//
//  ContentView.swift
//  iExpense
//
//  Created by Ian Huettel on 1/24/21.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Banana"
    @Published var lastName = "Sam"
}

struct nameChangeSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var person: User
    
    var body: some View {
        TextField("First Name: ", text: $person.firstName)
        TextField("Last Name: ", text: $person.lastName)
        
        Button("Dismiss") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    init(for person: User) {
        self.person = person
    }
}

struct ContentView: View {
    @ObservedObject private var person = User()
    
    @State private var showNameSheet = false
    
    @State private var namesList = [String]()
    
    func removeRows(at offsets: IndexSet) {
        namesList.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                        Text("Hello, \(person.firstName) \(person.lastName)!")
                    .padding()
                    
                    Button("Change name") {
                        showNameSheet = true
                    }
                }
                
                Button("Save name") {
                    namesList.append("\(person.firstName) \(person.lastName)")
                }
                
                Section {
                    List {
                        ForEach(namesList, id: \.self) {
                            Text($0)
                        }
                        .onDelete(perform: removeRows)
                    }
                }
            }
            .navigationBarItems(leading: EditButton())
            .sheet(isPresented: $showNameSheet) {
                nameChangeSheet(for: person)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
