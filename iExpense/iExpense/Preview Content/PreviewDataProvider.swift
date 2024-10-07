//
//  PreviewDataProvider.swift
//  iExpense
//
//  Created by Pavel Bartashov on 6/10/2024.
//

import SwiftData

@MainActor
struct PreviewDataProvider {

    let container: ModelContainer!
    let demoExpenseItem: ExpenseItem!
    let error: Error?

    init() {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: ExpenseItem.self, configurations: config)

            try container.mainContext.delete(model: ExpenseItem.self)

            self.demoExpenseItem = ExpenseItem(name: "Expense business", type: .business, amount: 100)
            container.mainContext.insert(demoExpenseItem)

            self.container = container
            self.error = nil

            addMoreExpenses()
        } catch {
            self.container = nil
            self.demoExpenseItem = nil
            self.error = error
        }
    }

    private func addMoreExpenses() {
        let first = ExpenseItem(name: "Expense 1", type: .personal, amount: 10)

        container.mainContext.insert(first)

        let second = ExpenseItem(name: "Expense 2", type: .personal, amount: 8)

        container.mainContext.insert(second)

        let third = ExpenseItem(name: "Expense 3", type: .business, amount: 4)
        container.mainContext.insert(third)
    }
}
