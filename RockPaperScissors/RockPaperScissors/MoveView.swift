//
//  MoveView.swift
//  RockPaperScissors
//
//  Created by Pavel Bartashov on 19/9/2024.
//

import SwiftUI

struct MoveView: View {

    let move: Move
    let size: Double

    var body: some View {
        Text(move.rawValue)
            .font(.system(size: size))
    }
}
