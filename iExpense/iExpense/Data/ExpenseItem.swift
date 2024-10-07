//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Pavel Bartashov on 26/9/2024.
//

import Foundation
import SwiftData

@Model
final class ExpenseItem: Identifiable {
    var id: UUID
    var name: String
    var amount: Double
    
    var typeRaw = ExpenseType.defaultValue.rawValue
    var type: ExpenseType {
        get { .init(rawValue: typeRaw) ?? .defaultValue }
        set { typeRaw = newValue.rawValue }
    }
    
    init(id: UUID = UUID(), name: String, type: ExpenseType, amount: Double) {
        self.id = id
        self.name = name
        self.amount = amount
        self.type = type
    }
}
