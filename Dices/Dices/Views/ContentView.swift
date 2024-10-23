//
//  ContentView.swift
//  Dices
//
//  Created by Pavel Bartashov on 23/10/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {

    private var timer = Timer
        .publish(every: 0.03, tolerance: 0.01, on: .main, in: .common)
        .autoconnect()

    private let availableDices: [Int] = [4, 6, 8, 10, 12, 20, 100]

    @Environment(\.modelContext) private var modelContext

    @State private var currentDice = 6
    @State private var rollResults: [Int?] = [nil]
    @State private var numberOfDices = 1

    @State private var total: Int?

    @Query(sort: [SortDescriptor(\DiceResult.date, order: .reverse)])
    private var resultsHistory: [DiceResult]

    @State private var isRollingInProgress = false
    @State private var progress = 0.0
    @State private var checkPoint = 10.0

    var body: some View {
        NavigationStack {
            Form {
                Section("Number of dices:") {
                    Picker("Number of dices:", selection: $numberOfDices) {
                        ForEach(1..<6, id: \.self) { index in
                            Text("\(index)").tag(index)
                        }
                    }
                    .pickerStyle(.segmented)
                    .disabled(isRollingInProgress)
                }

                Section("Number of sides:") {
                    Picker("Number of sides:", selection: $currentDice) {
                        ForEach(0..<availableDices.count, id: \.self) { index in
                            Text("\(availableDices[index])").tag(availableDices[index])
                        }
                    }
                    .pickerStyle(.segmented)
                    .disabled(isRollingInProgress)
                }

                VStack(alignment: .center) {
                    HStack {
                        ForEach(0..<rollResults.count, id: \.self) { index in
                            Text("\(rollResults[index]?.formatted() ?? "?")")
                                .font(.largeTitle)
                                .frame(maxWidth: .infinity)
                        }
                    }

                    Button("Roll", action: startRolling)
                        .buttonStyle(.borderedProminent)
                        .disabled(isRollingInProgress)

                    Text("\(total?.formatted() ?? "?")")
                        .font(.largeTitle)
                }

                if resultsHistory.isEmpty == false {
                    Section("Hystory") {
                        List {
                            ForEach(resultsHistory, id: \.self) { result in
                                Text("\(result.value)")
                            }
                            .onDelete(perform: deleteResult)
                        }
                    }
                }
            }
            .navigationTitle("Dices")
            .toolbar {
                EditButton()
            }
            .onChange(of: numberOfDices) {
                rollResults = Array(repeating: nil, count: numberOfDices)
            }
            .onReceive(timer) { _ in
                doNextRoll()
            }
            .sensoryFeedback(.selection, trigger: resultsHistory)
        }
    }

    private func deleteResult(offsets: IndexSet) {
        for offset in offsets {
            let diceResult = resultsHistory[offset]
            modelContext.delete(diceResult)
        }
    }

    private func startRolling() {
        isRollingInProgress = true
        total = nil
    }

    private func doNextRoll() {
        guard isRollingInProgress else { return }
        progress += 1

        if checkPoint < progress {
            checkPoint *= 1.1

            (0..<rollResults.count).forEach {
                let result = Int.random(in: 1...currentDice)
                rollResults[$0] = result
            }

            if checkPoint > 100 {
                stopRolling()
            }
        }
    }

    private func stopRolling() {
        isRollingInProgress = false
        progress = 0
        checkPoint = 10

        let total = rollResults
            .compactMap { $0 }
            .reduce(0, +)

        let diceResult = DiceResult(value: total)
        modelContext.insert(diceResult)
        self.total = total
    }
}

#Preview {
    ContentView()
        .modelContainer(for: DiceResult.self)
}
