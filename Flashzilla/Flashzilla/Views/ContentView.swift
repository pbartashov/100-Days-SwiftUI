//
//  ContentView.swift
//  Flashzilla
//
//  Created by Pavel Bartashov on 17/10/2024.
//

import SwiftUI

struct ContentView: View {

    let cardStore = CardStore()

    @Environment(\.accessibilityDifferentiateWithoutColor) private var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) private var accessibilityVoiceOverEnabled
    @Environment(\.scenePhase) private var scenePhase

    @State private var cards = [Card]()

    @State private var isActive = true

    @State private var timeRemaing = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State private var isShowingEditScreen = false

    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Timer: \(timeRemaing)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)

                ZStack {
                    ForEach(cards) { card in
                        if let index = cards.firstIndex(of: card) {
                            CardView(card: card) { isCorrect in
                                withAnimation {
                                    handleAnswer(at: cards.count - 1, isCorrect: isCorrect)
                                }
                            }
                            .stacked(at: index, in: cards.count)
                            .allowsHitTesting(index == cards.count - 1)
                            .accessibilityHidden(index < cards.count - 1)
                        } else {
                            EmptyView()
                        }
                    }
                }
                .allowsHitTesting(timeRemaing > 0)

                if cards.isEmpty {
                    Button("Start again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }

            VStack {
                HStack {
                    Spacer()

                    Button {
                        isShowingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }

                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()

            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                Spacer()

                HStack {
                    Button {
                        withAnimation {
                            handleAnswer(at: cards.count - 1, isCorrect: false)
                        }
                    } label: {
                        Image(systemName: "xmark.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)

                    }
                    .accessibilityLabel("Wrong")
                    .accessibilityHint("Mark your answer as being incorrect")

                    Spacer()

                    Button {
                        withAnimation {
                            handleAnswer(at: cards.count - 1, isCorrect: true)
                        }
                    } label: {
                        Image(systemName: "checkmark.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)

                    }
                    .accessibilityLabel("Correct")
                    .accessibilityHint("Mark your answer as being correct")
                }
                .foregroundStyle(.white)
                .font(.largeTitle)
                .padding()
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }

            if timeRemaing > 0 {
                timeRemaing -= 1
            }
        }
        .onChange(of: scenePhase) {
            isActive = scenePhase == .active && cards.isEmpty == false
        }
        .sheet(isPresented: $isShowingEditScreen, onDismiss: resetCards, content: EditCards.init)
        .onAppear(perform: resetCards)
    }

    private func handleAnswer(at index: Int, isCorrect: Bool) {
        if isCorrect {
            removeCard(at: index)
        } else {
            moveCardToBottom(index)
        }
    }

    private func removeCard(at index: Int) {
        guard index >= 0 else { return }
        cards.remove(at: index)

        if cards.isEmpty {
            isActive = false
        }
    }

    private func moveCardToBottom(_ index: Int) {
        var card = cards[index]
        removeCard(at: index)

        card.id = UUID()
        cards.insert(card, at: 0)
    }

    private func resetCards() {
        timeRemaing = 100
        isActive = true

        cards = cardStore.loadCards()
    }
}

#Preview(traits: .landscapeLeft) {
    ContentView()
}
