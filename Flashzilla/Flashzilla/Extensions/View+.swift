//
//  View+.swift
//  Flashzilla
//
//  Created by Pavel Bartashov on 18/10/2024.
//

import SwiftUI

extension View {
    func stacked(at position : Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}
