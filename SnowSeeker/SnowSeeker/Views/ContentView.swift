//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Pavel Bartashov on 24/10/2024.
//

import SwiftUI

struct ContentView: View {

    private enum Sort: String, CaseIterable {
        case none = "No sorting"
        case name = "Sort by name"
        case country = "Sort by country"
    }

    @State private var resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var searchText = ""
    @State private var favorites = Favorites()
    @State private var sorting = Sort.none

    private var filteredResorts: [Resort] {
        if searchText.isEmpty {
            resorts
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchText) }
        }
    }

    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                .rect(cornerRadius: 5)
                            )
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            }

                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)

                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }

                        if favorites.contains(resort) {
                            Spacer()

                            Image(systemName: "star.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.yellow)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Picker("Sort", selection: $sorting) {
                            ForEach(Sort.allCases, id: \.self) { sort in
                                Text(sort.rawValue).tag(sort)
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
            .onChange(of: sorting) {
                sortResorts()
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }

    private func sortResorts() {
        switch sorting {
            case .none:
                resorts = Bundle.main.decode("resorts.json")
            case .name:
                resorts = resorts.sorted { $0.name < $1.name  }
            case .country:
                resorts = resorts.sorted { $0.country < $1.country  }
        }
    }
}

#Preview {
    ContentView()
}
