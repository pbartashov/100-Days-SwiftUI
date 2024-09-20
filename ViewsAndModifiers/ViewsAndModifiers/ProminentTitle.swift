//
//  ProminentTitle.swift
//  ViewsAndModifiers
//
//  Created by Pavel Bartashov on 19/9/2024.
//

import SwiftUI

// MARK: - Definition

struct ProminentTitle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(Color.accentColor)
    }
}

// MARK: - Extension

extension View {
    func prominentStyle() -> some View {
        modifier(ProminentTitle())
    }
}

// MARK: - Use (Preview)

struct TestProminentTitle: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .prominentStyle()
    }
}

#Preview {
    TestProminentTitle()
}
