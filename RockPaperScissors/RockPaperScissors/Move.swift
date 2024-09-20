//
//  Move.swift
//  RockPaperScissors
//
//  Created by Pavel Bartashov on 19/9/2024.
//

import Foundation

enum Move: String {
    case rock = "🪨"
    case paper = "📜"
    case scissors = "✂️"
}

extension Move {
    static let availableMoves: [Move] = [
        .rock,
        .paper,
        .scissors
    ]

    static func random() -> Move {
        availableMoves.randomElement() ?? .paper
    }
}
