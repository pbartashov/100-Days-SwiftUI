//
//  HabitsStore.swift
//  Habits
//
//  Created by Pavel Bartashov on 2/10/2024.
//

import Foundation

@Observable
final class HabitsStore {
    var habits: [Habit] {
        didSet {
            HabitsStore.save(habits)
        }
    }

    init(habits: [Habit] = HabitsStore.load()) {
        self.habits = habits
    }
}

extension HabitsStore {
    static func load() -> [Habit] {
        guard
            let data = UserDefaults.standard.data(forKey: Constants.habitsUserDefaultKey),
            let decoded = try? JSONDecoder().decode([Habit].self, from: data)
        else {
            return []
        }

        return decoded
    }

    static func save(_ habits: [Habit]) {
        if let data = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.setValue(data, forKey: Constants.habitsUserDefaultKey)
        }
    }
}
