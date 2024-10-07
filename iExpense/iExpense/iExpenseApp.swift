//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Pavel Bartashov on 26/9/2024.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
