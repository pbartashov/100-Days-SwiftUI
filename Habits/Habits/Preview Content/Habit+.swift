//
//  Habit+.swift
//  Habits
//
//  Created by Pavel Bartashov on 1/10/2024.
//

import Foundation

extension Habit {
    static var demo: Habit {
        Habit(
            id: UUID(),
            title: "Coding",
            description: "Coding...Coding...Coding",
            completedCount: 5
        )
    }
}
