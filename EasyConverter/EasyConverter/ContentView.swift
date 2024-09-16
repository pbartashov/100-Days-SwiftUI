//
//  ContentView.swift
//  EasyConverter
//
//  Created by Pavel Bartashov on 13/9/2024.
//

import SwiftUI

struct ContentView: View {

    @FocusState private var amountIsFocused: Bool

    @State private var inputUnits: UnitDuration = .minutes
    @State private var outputUnits: UnitDuration = .seconds
    @State private var inputValue = 1.0
    //    @State private var outputAmount = 0.0

    let availableUnits: [UnitDuration] = [
        .seconds,
        .minutes,
        .hours,
        .days
    ]

    var outputValue: Double {
        let inputMeasurement = Measurement(value: inputValue, unit: inputUnits)
        let outputMeasurement = inputMeasurement.converted(to: outputUnits)

        return outputMeasurement.value
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("1. Enter the amount") {
                    TextField(
                        "Amount",
                        value: $inputValue,
                        format: .number
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)

                }

                Section("2. Select unit for the amount") {
                    Picker("Input units", selection: $inputUnits) {
                        ForEach(availableUnits, id: \.self) {
                            Text($0.symbol).tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("3. Select unit for the result") {
                    Picker("Output units", selection: $outputUnits) {
                        ForEach(availableUnits, id: \.self) {
                            Text($0.symbol).tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("4. Read the result") {
                    Text(outputValue, format: .number)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.title)
                }
            }
            .navigationTitle("Easy converter")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        if amountIsFocused {
                            amountIsFocused = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
