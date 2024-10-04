//
//  String+.swift
//  Bookworm
//
//  Created by Pavel Bartashov on 4/10/2024.
//

import Foundation

extension String {
    var hasNotContent: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
