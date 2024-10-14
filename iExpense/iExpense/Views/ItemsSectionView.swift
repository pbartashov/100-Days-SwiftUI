//
//  ItemsSectionView.swift
//  iExpense
//
//  Created by Pavel Bartashov on 27/9/2024.
//

import SwiftData
import SwiftUI

struct ItemsSectionView: View {

    @Query var items: [ExpenseItem]

    let title: String
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
                .accessibilityLabel("\(item.name) \(item.amount)")
                .accessibilityHint(item.type.rawValue)
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

    init(
        title: String,
        filterBy: ExpenseType,
        sort: [SortDescriptor<ExpenseItem>],
        deletion: @escaping ([UUID]) -> Void
    ) {
        _items = Query(
            filter: #Predicate<ExpenseItem> {
                $0.typeRaw == filterBy.rawValue
            },
            sort: sort
        )

        self.title = title
        self.deletion = deletion
    }
}
