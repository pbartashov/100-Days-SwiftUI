//
//  ItemsSectionView.swift
//  iExpense
//
//  Created by Pavel Bartashov on 27/9/2024.
//

import SwiftUI

struct ItemsSectionView: View {

    let title: String
    let items: [ExpenseItem]
    let deletion: ([UUID]) -> Void

    var body: some View {
        Section(title) {
            ForEach(items) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type.rawValue)
                    }
                    
                    Spacer()
                    
                    Text(
                        item.amount,
                        format: .currency(
                            code: Locale.current.currency?.identifier ?? "USD"
                        )
                    )
                    .foregroundStyle(color(for: item.amount))
                }
            }
            .onDelete(perform: removeItems)
        }
    }

    private func removeItems(at offsets: IndexSet) {
        let uuidToDelete = offsets.map {
            items[$0].id
        }

        deletion(uuidToDelete)
    }

    private func color(for amount: Double) -> Color {
        amount < 10
            ? .green
            : amount < 100
                ? .black
                : .red
    }
}
