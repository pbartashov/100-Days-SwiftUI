//
//  AddView.swift
//  iExpense
//
//  Created by Pavel Bartashov on 26/9/2024.
//

import SwiftUI

struct AddView: View {

    @Environment(\.dismiss) var dismiss

    let expenses: Expenses

    @State private var name = "Name"
    @State private var type = ExpensesTypes.personal
    @State private var amount = 0.0

    let types: [ExpensesTypes] = [.business, .personal]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0.rawValue)
                    }
                }

                TextField(
                    "Amount",
                    value: $amount,
                    format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                )
                .keyboardType(.numberPad)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle($name)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        let expense = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(expense)

                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
