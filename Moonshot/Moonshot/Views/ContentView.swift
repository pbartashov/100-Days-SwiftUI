//
//  ContentView.swift
//  Moonshot
//
//  Created by Pavel Bartashov on 27/9/2024.
//

import SwiftUI

struct ContentView: View {

    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State private var showingGrid = true
    private var buttonTitle: String {
        showingGrid ? "List" : "Grid"
    }

    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    GridLayout(missions: missions, astronauts: astronauts)
                } else {
                    ListLayout(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button(buttonTitle) {
                    showingGrid.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
