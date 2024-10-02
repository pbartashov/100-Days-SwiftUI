//
//  Habit.swift
//  Habits
//
//  Created by Pavel Bartashov on 1/10/2024.
//

import SwiftUI

struct Habit: Identifiable {
    let id: UUID
    var title: String
    var description: String
    var completedCount: Int

    init(
        id: UUID = UUID(),
        title: String = "",
        description: String = "",
        completedCount: Int = 0
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.completedCount = completedCount
    }
}

extension Habit: Hashable { }

extension Habit: Codable { }
