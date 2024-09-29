//
//  Astronaut.swift
//  Moonshot
//
//  Created by Pavel Bartashov on 27/9/2024.
//

import Foundation

struct Astronaut: Identifiable {
    let id: String
    let name: String
    let description: String
}

extension Astronaut: Codable { }
