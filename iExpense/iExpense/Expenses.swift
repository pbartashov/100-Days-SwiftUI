//
//  Expenses.swift
//  iExpense
//
//  Created by Pavel Bartashov on 26/9/2024.
//

import Foundation

@Observable
final class Expenses {
    struct Constants {
        static let itemKey = "Items"
    }

    var items = [ExpenseItem]() {
        didSet {
            if let data = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(data, forKey: Constants.itemKey)
            }
        }
    }

    init() {
        if let data = UserDefaults.standard.data(forKey: Constants.itemKey),
           let savedItems = try? JSONDecoder().decode([ExpenseItem].self, from: data) {

            items = savedItems
        } else {
            items = []
        }
    }
}
