//
//  ExpenseType.swift
//  iExpense
//
//  Created by Pavel Bartashov on 27/9/2024.
//

import Foundation

enum ExpenseType: String {
    case all = "All"
    case personal = "Personal"
    case business = "Business"
}

extension ExpenseType {
    static let defaultValue = ExpenseType.personal
}

extension ExpenseType: Codable { }

extension ExpenseType: CaseIterable { }
