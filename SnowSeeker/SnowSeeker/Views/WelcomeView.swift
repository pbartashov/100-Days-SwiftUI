//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Pavel Bartashov on 24/10/2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        Text("Welcome to SnowSeeker!")
            .font(.largeTitle)
        
        Text("Please select a resort from a left-hand menu; swipe from the left edge to show it.")
            .foregroundStyle(.secondary)
    }
}

#Preview {
    WelcomeView()
}
