//
//  ContentView.swift
//  BetterRest
//
//  Created by Pavel Bartashov on 20/9/2024.
//

import SwiftUI

struct ContentView: View {

    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    static private var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0

        return Calendar.current.date(from: components) ?? .now
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time",
                               selection: $wakeUp,
                               displayedComponents: .hourAndMinute
                    )
                    .labelsHidden()
                    .frame(maxWidth: .infinity, alignment: .center)
                }

                Section("Desired time of sleep") {
                    Stepper(
                        "\(sleepAmount.formatted()) hours",
                        value: $sleepAmount,
                        in: 4...21,
                        step: 0.25
                    )
                }

                Section("Daily coffe intake") {
                    Stepper(
                        "^[\(coffeeAmount) cup](inflect: true)",
                        value: $coffeeAmount,
                        in: 0...20
                    )
                }

                Section("Your ideal bedtime is") {
                    Text(calculateBedTime())
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("BetterRest")
        }
    }

    private func calculateBedTime() -> String {

        let bedTime: String

        do {
            let sleepTime = try BedTimeCalculator.calculate(
                wakeUp: wakeUp,
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount)
            )

            bedTime = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            bedTime = "Sorry, there was a problem calculating your bedtime."
        }

        return bedTime
    }
}

#Preview {
    ContentView()
}
