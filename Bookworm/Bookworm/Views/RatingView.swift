//
//  RatingView.swift
//  Bookworm
//
//  Created by Pavel Bartashov on 3/10/2024.
//

import SwiftUI

struct RatingView: View {

    @Binding var rating: Int

    var label = ""

    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow

    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumRating + 1, id: \.self) { number in
                Button {
                    rating = number
                } label: {
                    image(for: number)
                        .foregroundColor(rating >= number ? onColor : offColor)
                }
            }
        }
        .buttonStyle(.plain) // Important when used inside Form or List
    }

    private func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        }

        return onImage
    }
}

#Preview {
    @Previewable @State var rating: Int = 4
    RatingView(rating: $rating)
}
