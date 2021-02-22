//
//  Bundle-DecodeExtension.swift
//  Moonshot
//
//  Created by Ian Huettel on 2/21/21.
//

import Foundation

extension Bundle {
    func decode(_ file: String) -> [Astronaut] {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to get \(file) data from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let decoded = try? decoder.decode([Astronaut].self, from: data) else {
            fatalError("Failed to decode \(file) data from bundle.")
        }
        
        return decoded
    }
}
