//
//  ContentView+ViewModel.swift
//  BucketList
//
//  Created by Pavel Bartashov on 11/10/2024.
//

import Foundation
import LocalAuthentication
import MapKit

extension ContentView {

    enum MapStyle: Identifiable {
        var id: Int {
            self.hashValue
        }

        case standard
        case hybrid

        var title: String {
            switch self {
                case .standard:
                    "Standard"
                case .hybrid:
                    "Hybrid"
            }
        }
    }

    @Observable
    final class ViewModel {
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")

        var selectedPlace: Location?

        var error: Error?
        var errorDescription: String {
            error?.localizedDescription ?? ""
        }
        var showingError: Bool {
            get {
                error != nil
            }
            set {
                error = nil
            }
        }

        private(set) var locations: [Location] {
            didSet {
                save()
            }
        }

        var isUnlocked = true

        let availableMapStyles: [MapStyle] = [
            .standard,
            .hybrid
        ]
        var currentMapStyle = MapStyle.standard

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }

        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
        }

        func update(location: Location) {
            guard let selectedPlace else { return }

            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
        }

        @MainActor
        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                    if success {
                        self.isUnlocked = true
                        self.error = nil
                    } else {
                        self.error = authenticationError
                    }
                }
            } else {
                self.error = error
            }
        }

        private func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
    }
}
