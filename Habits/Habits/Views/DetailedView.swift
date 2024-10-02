//
//  DetailedView.swift
//  Habits
//
//  Created by Pavel Bartashov on 1/10/2024.
//

import SwiftUI

struct DetailedView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var habit: Habit

    let updateHabit: (HabitUpdate) -> Void

    var body: some View {
        Button("Mark as done", systemImage: "checkmark") {
            habit.completedCount += 1
            updateHabit(.count(habit.completedCount))
        }

        Form {
            TextField("Title", text: $habit.title)
                .font(.title)

            TextField("Description", text: $habit.description, axis: .vertical)
                .lineLimit(5...100)

            Stepper("Completed \(habit.completedCount)",
                    value: $habit.completedCount,
                    in: 0...Int.max
            )
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle($habit.title)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }

            ToolbarItemGroup(placement: .confirmationAction) {
                Button("Save") {
                    updateHabit(.habit(habit))
                    dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }

    init(
        habit: Habit,
        updateHabit: @escaping (HabitUpdate) -> Void
    ) {
        self.habit = habit
        self.updateHabit = updateHabit
    }
}

#Preview {
    NavigationStack {
        DetailedView(habit: Habit.demo, updateHabit: { _ in })
    }
}
