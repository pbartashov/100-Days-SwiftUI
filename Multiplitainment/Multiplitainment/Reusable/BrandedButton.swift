//
//  BrandedButton.swift
//  Multiplitainment
//
//  Created by Pavel Bartashov on 25/9/2024.
//

import SwiftUI

struct BrandedButton<Title: View, Icon: View>: View {

    let action: @MainActor () -> Void
    @ViewBuilder let label: Label<Title, Icon>

    @State private var shadowRadius: CGFloat = 0

    var body: some View {
        Button(action: action) {
            label
                .font(.largeTitle)
                .padding()
        }
        .background(.ultraThinMaterial)
        .clipShape(Capsule(style: .circular))
        .shadow(color: .white, radius: shadowRadius)
        .animation(
            .easeInOut(duration: 1.5)
            .repeatForever(autoreverses: true),
            value: shadowRadius
        )
        .onAppear {
            shadowRadius = 7
        }
    }
}

#Preview {
    ZStack {
        Color.teal
            .ignoresSafeArea()
        BrandedButton {
            ()
        } label: {
            Label("Start", image: "circle")
        }
    }
}

