//
//  CurrencyText.swift
//  WeSplit
//
//  Created by Pavel Bartashov on 13/9/2024.
//

import SwiftUI

struct CurrencyText<F: BinaryFloatingPoint>: View {

    private let value: F

    var body: some View {
        Text(
            value,
            format: FloatingPointFormatStyle<F>.Currency(
                code: Locale.current.currency?.identifier ?? "USD"
            )
        )
    }

    init(_ value: F) {
        self.value = value
    }
}

#Preview {
    CurrencyText(5)
}
