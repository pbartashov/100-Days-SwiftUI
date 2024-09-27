//
//  ContentView.swift
//  iExpense
//
//  Created by Pavel Bartashov on 26/9/2024.
//

import SwiftUI

struct ContentView: View {

    @State private var expenses = Expenses()
    @State private var showingAddExpense = false

    private var pesonalExpenses: [ExpenseItem] {
        expenses.items.filter {
            $0.type == .personal
        }
    }

    private var businessExpenses: [ExpenseItem] {
        expenses.items.filter {
            $0.type == .business
        }
    }

    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ItemsSectionView(
                        title: ExpensesTypes.personal.rawValue,
                        items: pesonalExpenses,
                        deletion: removeItems
                    )

                    ItemsSectionView(
                        title: ExpensesTypes.business.rawValue,
                        items: businessExpenses,
                        deletion: removeItems
                    )
                }
                .navigationTitle("iExpenses")
                .toolbar {
                    Button("Add Expense", systemImage: "plus") {
                        showingAddExpense = true
                    }
                }
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: expenses)
                }
            }
        }
    }

    private func removeItems(withIds uuids: [UUID]) {
        expenses.items.removeAll {
            uuids.contains($0.id)
        }
    }
}

#Preview {
    ContentView()
}
