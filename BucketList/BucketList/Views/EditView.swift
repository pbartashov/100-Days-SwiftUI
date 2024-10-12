//
//  EditView.swift
//  BucketList
//
//  Created by Pavel Bartashov on 11/10/2024.
//

import SwiftUI

struct EditView: View {
    enum LoadingState {
        case loading, loaded, failed
    }

    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void

    @State private var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }

                Section("Nearby...") {
                    switch viewModel.loadingState {
                        case .loading:
                            Text("loading...")
                        case .loaded:
                            ForEach(viewModel.pages, id: \.pageid) { page in
                                Text(page.title)
                                    .font(.headline)

                                + Text(": ") +

                                Text(page.description)
                                    .italic()
                            }
                        case .failed:
                            Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    onSave(viewModel.updatedLocation())
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }

    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        self._viewModel = State(
            initialValue: ViewModel(
                location: location,
                name: location.name,
                description: location.description
            )
        )
    }
}

#Preview {
    EditView(location: .example) { _ in }
}
