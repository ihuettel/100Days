//
//  TextView.swift
//  Moonshot
//
//  Created by Ian Huettel on 2/21/21.
//

import SwiftUI

struct NewPage: View {
    let name: String
    let description: String
    
    var body: some View {
        ScrollView {
            Text("About \(name):")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Text("")
            Text(description)
        }
    }
}
