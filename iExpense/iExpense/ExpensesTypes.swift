//
//  ExpensesTypes.swift
//  iExpense
//
//  Created by Pavel Bartashov on 27/9/2024.
//

import Foundation

enum ExpensesTypes: String {
    case personal = "Personal"
    case business = "Business"
}

extension ExpensesTypes: Codable { }
