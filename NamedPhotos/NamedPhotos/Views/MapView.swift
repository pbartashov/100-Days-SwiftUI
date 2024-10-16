//
//  MapView.swift
//  NamedPhotos
//
//  Created by Pavel Bartashov on 15/10/2024.
//

import MapKit
import SwiftUI

struct MapView: View {
    let fetcher = LocationFetcher()

    @Binding var item: Item
    @State private var errorMessage: String?

    private var initialPosition: MapCameraPosition? {
        if let location = item.location {
            return MapCameraPosition.region(for: location)
        } else {
            return nil
        }
    }

    var body: some View {
        Group {
            if let initialPosition, let location = item.location {
                MapReader { proxy in
                    Map(initialPosition: initialPosition) {
                        Marker(item.name, coordinate: CLLocationCoordinate2D(location: location))
                            .tint(.orange)
                    }
                    .gesture(
                        LongPressGesture(minimumDuration: 0.5)
                            .sequenced(before: DragGesture(minimumDistance: 0))
                            .onEnded { value in
                                switch value {
                                    case .second(true, let drag):
                                        if let point = drag?.location,
                                           let clLocation = proxy.convert(point, from: .local)
                                        {
                                            item.location = Location(clCoordinate:  clLocation)
                                        }
                                    default:
                                        break
                                }
                            }
                    )
                }
            } else {
                ContentUnavailableView {
                    Image(systemName: "location.slash")
                } description: {
                    Text("Location unavailable.")
                } actions: {
                    Button("Choose location manually") {
                        Task {
                            await requestLocation()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }

            if let errorMessage {
                Text(errorMessage)
            }
        }
        .task {
            if item.isNew {
                await requestLocation()
            }
        }
    }

    private func requestLocation() async {

        fetcher.start()

        do {
            let clLocation = try await fetcher.currentLocation
            item.location = Location(clLocation: clLocation)
            errorMessage = nil
        } catch {
            item.location = Location.default
            errorMessage = error.localizedDescription
        }
    }
}

#Preview("With location") {
    MapView(item: .constant(Item.demo))
}

#Preview("New") {
    var demo = Item.demoNoLocation
    demo.isNew = true

    return MapView(item: .constant(demo))
}

#Preview("Empty") {
    MapView(item: .constant(Item.demoNoLocation))
}

extension Location {
    convenience init(clLocation: CLLocation) {
        self.init(clCoordinate: clLocation.coordinate)
    }

    convenience init(clCoordinate: CLLocationCoordinate2D) {
        self.init(
            latitude: clCoordinate.latitude,
            longitude: clCoordinate.longitude
        )
    }
}

extension MapCameraPosition {
    static func region(for location: Location) -> MapCameraPosition {
        MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(location: location),
                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            )
        )
    }
}

extension CLLocationCoordinate2D {
    init(location: Location) {
        self.init(latitude: location.latitude, longitude: location.longitude)
    }
}
