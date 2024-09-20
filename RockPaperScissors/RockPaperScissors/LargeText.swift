//
//  LargeText.swift
//  RockPaperScissors
//
//  Created by Pavel Bartashov on 19/9/2024.
//

import SwiftUI

struct LargeText<S: StringProtocol>: View {

    let text: S
    let color: Color

    var body: some View {
        Text(text)
            .foregroundStyle(color)
            .font(.largeTitle)
    }
}
