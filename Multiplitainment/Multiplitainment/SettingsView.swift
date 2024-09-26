//
//  SettingsView.swift
//  Multiplitainment
//
//  Created by Pavel Bartashov on 25/9/2024.
//

import SwiftUI

struct SettingsView: View {

    @State private var multiplier = 5

    @State private var selectedNumberOfAnswers = 10
    @State private var availableNumbersOfAnswers = [5, 10, 20]

    let onStart: (Int, Int) -> Void

    var body: some View {
        VStack {
            Spacer()

            UltraThinCard(spacing: 10) {
                TitleText("Multiplication tables up to")

                TitleText("\(multiplier.formatted())")

                Stepper("Multiplier",
                        value: $multiplier,
                        in: 2...12
                )
                .labelsHidden()
            }

            Spacer()

            UltraThinCard {
                TitleText("Number of questions")

                Picker("Answer count", selection: $selectedNumberOfAnswers) {
                    ForEach(availableNumbersOfAnswers, id: \.self) {
                        Text("\($0)").tag($0)
                    }
                }
                .pickerStyle(.segmented)

            }

            Spacer()

            BrandedButton {
                onStart(multiplier, selectedNumberOfAnswers)
            } label: {
                Label("Start!", systemImage: "figure.run")
            }

            Spacer()

        }
        .foregroundStyle(.white)
    }
}

#Preview {
    ZStack {
        Color.teal
            .ignoresSafeArea()
        SettingsView(onStart: { _, _ in })
    }
}
