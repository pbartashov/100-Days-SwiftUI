//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Pavel Bartashov on 26/9/2024.
//

import Foundation

struct ExpenseItem: Identifiable {
    let id: UUID
    let name: String
    let type: ExpensesTypes
    let amount: Double

    init(id: UUID = UUID(), name: String, type: ExpensesTypes, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}

extension ExpenseItem: Codable { }
