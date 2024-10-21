//
//  Card.swift
//  Flashzilla
//
//  Created by Pavel Bartashov on 18/10/2024.
//

import Foundation

struct Card: Identifiable {
    var id: UUID = UUID()
    var prompt: String
    var answer: String
}

extension Card: Codable { }
extension Card: Equatable { }
