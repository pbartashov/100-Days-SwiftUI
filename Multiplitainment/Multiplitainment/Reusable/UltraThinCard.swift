//
//  UltraThinCard.swift
//  Multiplitainment
//
//  Created by Pavel Bartashov on 25/9/2024.
//

import SwiftUI

struct UltraThinCard<Content: View>: View {

    let spacing: CGFloat?
    @ViewBuilder let content: Content

    var body: some View {
        VStack(spacing: spacing) {
            content
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }

    init(
        spacing: CGFloat? = nil,
        @ViewBuilder contentBuilder: () -> Content
    ) {
        self.spacing = spacing
        self.content = contentBuilder()
    }
}

#Preview {
    UltraThinCard(spacing: 15) {
        Text("Hello world!")
        Text("Hello world!")
    }
}
