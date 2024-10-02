//
//  ContentView.swift
//  Habits
//
//  Created by Pavel Bartashov on 1/10/2024.
//

import SwiftUI

struct ContentView: View {

    @State private var pathStore = PathStore()

    @State private var habitsStore = HabitsStore()

    @State private var showingAddNew = false

    var body: some View {
        NavigationStack(path: $pathStore.path) {
            List(habitsStore.habits) { habit in
                NavigationLink(value: habit) {
                    HStack {
                        Text(habit.title)
                        
                        Spacer()
                        
                        Text(habit.completedCount.formatted(.number))
                    }
                }
            }
            .navigationDestination(for: Habit.self) { habit in
                detailedView(for: habit)
            }
            .navigationDestination(isPresented: $showingAddNew) {
                detailedView(for: Habit())
            }
            .navigationTitle("Habits")
            .toolbar {
                Button("Add demo") {
                    habitsStore.habits += [Habit.demo]
                }

                Button("Add", systemImage: "plus") {
                    showingAddNew = true
                }
            }
        }
    }

    private func detailedView(for habit: Habit) -> some View {
        DetailedView(habit: habit) { [habit] update in
            guard let index = habitsStore.habits.firstIndex(of: habit) else {
                if case let .habit(updated) = update {
                    habitsStore.habits.append(updated)
                }
                return
            }

            switch update {
                case .habit(let updated):
                    habitsStore.habits[index] = updated
                case .count(let newCount):
                    habitsStore.habits[index].completedCount = newCount
            }
        }
    }
}

#Preview {
    ContentView()
}
