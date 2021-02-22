//
//  Mission.swift
//  Moonshot
//
//  Created by Ian Huettel on 2/21/21.
//

import Foundation


struct Mission: Codable, Identifiable {
    struct Crewmember: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: String?
    let crew: [Crewmember]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    var imageName: String {
        "apollo\(id)"
    }
}

