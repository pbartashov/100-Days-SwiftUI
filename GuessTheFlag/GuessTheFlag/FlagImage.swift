//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Pavel Bartashov on 19/9/2024.
//

import SwiftUI

struct FlagImage: View {

    let imageName: String

    var body: some View {
        Image(imageName)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

#Preview {
    FlagImage(imageName: "UK")
}
