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
    let launchDate: Date?
    let crew: [Crewmember]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    var imageName: String {
        "apollo\(id)"
    }
    var displayDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        }
        return "N/A"
    }
}

