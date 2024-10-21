//
//  ConditionalBackGround.swift
//  Flashzilla
//
//  Created by Pavel Bartashov on 20/10/2024.
//

import SwiftUI

struct ConditionalBackGround<S: Shape>: ViewModifier {
    let shape: S
    let isActive: Bool
    let color: Color

    func body(content: Content) -> some View {
        content
            .background(
                isActive
                ? shape
                    .fill(color)
                : nil
            )
    }
}

extension View {
    func conditionalBackGround<S: Shape> (shape: S, isActive: Bool, color: Color) -> some View {
        self.modifier(ConditionalBackGround(shape: shape, isActive: isActive, color: color))
    }
}
