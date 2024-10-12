//
//  ContentView.swift
//  BucketList
//
//  Created by Pavel Bartashov on 11/10/2024.
//

import MapKit
import SwiftUI

struct ContentView: View {

    @State private var viewModel = ViewModel()

    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )

    var body: some View {
        Group {
            if viewModel.isUnlocked {
                ZStack(alignment: .top) {
                    MapReader { proxy in
                        Map(initialPosition: startPosition) {
                            ForEach(viewModel.locations) { location in
                                Annotation(location.name, coordinate: location.coordinate) {
                                    Image(systemName: "star.circle")
                                        .resizable()
                                        .foregroundStyle(.red)
                                        .frame(width: 44, height: 44)
                                        .background(.white)
                                        .clipShape(.circle)
                                        .simultaneousGesture(LongPressGesture(minimumDuration: 1)
                                            .onEnded { _ in
                                                viewModel.selectedPlace = location
                                            }
                                        )
                                    //                                .onLongPressGesture {
                                    //                                    selectedPlace = location
                                    //                                }
                                }
                            }
                        }
                        .mapStyle(viewModel.currentMapStyle.toSwiftUIMapStyle)
                        .onTapGesture { position in
                            if let coordinate = proxy.convert(position, from: .local) {
                                viewModel.addLocation(at: coordinate)
                            }
                        }
                        .sheet(item: $viewModel.selectedPlace) { place in
                            EditView(location: place) {
                                viewModel.update(location: $0)
                            }
                        }
                    }

                    Picker("Select map style", selection: $viewModel.currentMapStyle) {
                        ForEach(viewModel.availableMapStyles) {
                            Text($0.title).tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            } else {
                VStack {
                    Button("Unlock places", action: viewModel.authenticate)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                }
            }
        }
        .alert("Error", isPresented: $viewModel.showingError) {
            Button("Ok", action: { })
        } message: {
            Text(viewModel.errorDescription)
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView.MapStyle {
    var toSwiftUIMapStyle: MapStyle {
        switch self {
            case .standard:
                    .standard
            case .hybrid:
                    .hybrid
        }
    }
}
