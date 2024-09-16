//
//  CurrencyField.swift
//  WeSplit
//
//  Created by Pavel Bartashov on 13/9/2024.
//

import SwiftUI

struct CurrencyField: View {

    private let title: String
    @Binding private var value: Double

    var body: some View {
        TextField(
            title,
            value: $value,
            format: .currency(code: Locale.current.currency?.identifier ?? "USD")
        )
        .keyboardType(.decimalPad)
    }

    init(_ title: String = "", value: Binding<Double>) {
        self.title = title
        self._value = value
    }
}

#Preview {
    @State var value = 5.0

    return CurrencyField("Test", value: $value)
}
