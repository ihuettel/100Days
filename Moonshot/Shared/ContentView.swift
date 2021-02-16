//
//  ContentView.swift
//  Shared
//
//  Created by homebase on 2/16/21.
//

import SwiftUI

struct User: Codable {
    var name: String
    var address: Address
}

struct Address: Codable {
    var street: String
    var city: String
}

struct ContentView: View {
    @State private var tSwift = User(name: "Someone", address: Address(street: "somewhere", city: "someplace"))
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Decode JSON") {
                    let input = """
                    {
                        "name": "Taylor Swift",
                        "address": {
                            "street": "555 Swift Avenue",
                            "city": "Nashville"
                        }
                    }
                    """
                    
                    let data = Data(input.utf8)
                    let decoder = JSONDecoder()
                    
                    if let user = try? decoder.decode(User.self, from: data) {
                        print(user.address.street)
                        tSwift = user
                    }
                    
                }
                List {
                    ForEach(0..<5) { row in
                        NavigationLink(destination: Text("\(tSwift.name) lives at \(tSwift.address.street) in \(tSwift.address.city).")) {
                            Text("This is row \(row)")
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
