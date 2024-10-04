//
//  String+.swift
//  CupcakeCorner
//
//  Created by Pavel Bartashov on 3/10/2024.
//

import Foundation

// MARK: - Misc

extension String {
    var hasValidContent: Bool {
        !self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

// MARK: - UserDefaults

extension String {
    static let orderUserDefaultsKey = "Order"
}
