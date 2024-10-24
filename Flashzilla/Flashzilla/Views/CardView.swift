//
//  CardView.swift
//  Flashzilla
//
//  Created by Pavel Bartashov on 18/10/2024.
//

import SwiftUI

struct CardView: View {

    let card: Card
    var handler: ((Bool) -> Void)? = nil

    @Environment(\.accessibilityDifferentiateWithoutColor) private var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) private var accessibilityVoiceOverEnabled
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    accessibilityDifferentiateWithoutColor
                    ? .white
                    : .white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .conditionalBackGround(
                    shape: RoundedRectangle(cornerRadius: 25),
                    isActive: !accessibilityDifferentiateWithoutColor && offset.width > 0,
                    color: .green
                )
                .conditionalBackGround(
                    shape: RoundedRectangle(cornerRadius: 25),
                    isActive: !accessibilityDifferentiateWithoutColor && offset.width < 0,
                    color: .red
                )
                .shadow(radius: 10)

            VStack {
                if accessibilityVoiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offset.width / 5.0))
        .offset(x: offset.width * 5)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { gesture in
                    if abs(offset.width) > 100 {
                        let answerIsCorrect = offset.width > 0
                        handler?(answerIsCorrect)
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.bouncy, value: offset)
    }
}

#Preview(traits: .landscapeLeft) {
    CardView(card: CardStore.example)
}
