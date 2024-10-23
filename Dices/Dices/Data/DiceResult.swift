//
//  DiceResult.swift
//  Dices
//
//  Created by Pavel Bartashov on 23/10/2024.
//

import Foundation
import SwiftData

@Model
final class DiceResult {
    var value: Int
    var date: Date

    init(value: Int, date: Date = .now) {
        self.value = value
        self.date = date
    }
}
