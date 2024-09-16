//
//  ContentView.swift
//  WeSplit
//
//  Created by Pavel Bartashov on 13/9/2024.
//

import SwiftUI

struct ContentView: View {

    @FocusState private var amountIsFocused: Bool
    @FocusState private var tipPercantageIsFocused: Bool

    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercantage = 20

    let tipPercantages =  [10, 15, 20, 25, 0]

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)

        return grandTotal / peopleCount
    }

    var grandTotal: Double {
        let tipSelection = Double(tipPercantage)
        let tipValue = checkAmount / 100 * tipSelection

        return checkAmount + tipValue
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    CurrencyField("Amount", value: $checkAmount)
                        .focused($amountIsFocused)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people").tag($0)
                        }
                    }
                }

                Section("How much tip do you want to leave?") {
                    Picker("Tip percantage", selection: $tipPercantage) {
                        ForEach(tipPercantages, id: \.self) {
                            Text($0, format: .percent)

                        }
                    }
                    .pickerStyle(.segmented)

                    Picker("or select tip percantage", selection: $tipPercantage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)

                        }
                    }
                    .pickerStyle(.navigationLink)
  
                    HStack {
                        Text("or enter manualy")

                        Spacer()

                        TextField(
                            "Tip percantage",
                            value: $tipPercantage,
                            format: .percent
                        )
                        .focused($tipPercantageIsFocused)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                    }
                }

                Section("Total amount for the check") {
                    CurrencyText(grandTotal)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }

                Section("Amount per person") {
                    CurrencyText(totalPerPerson)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.largeTitle)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused || tipPercantageIsFocused {
                    Button("Done") {
                        if tipPercantageIsFocused {
                            tipPercantageIsFocused = false
                        }

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
