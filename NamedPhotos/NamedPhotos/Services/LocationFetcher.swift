//
//  LocationFetcher.swift
//  NamedPhotos
//
//  Created by Pavel Bartashov on 15/10/2024.
//

import CoreLocation

// https://www.hackingwithswift.com/100/swiftui/78

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate

        // 4. If there is a location available
        if let lastLocation = locations.last {
            // 5. Resumes the continuation object with the user location as result
            continuation?.resume(returning: lastLocation)
            // Resets the continuation object
            continuation = nil
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // 6. If not possible to retrieve a location, resumes with an error
        continuation?.resume(throwing: error)
        // Resets the continuation object
        continuation = nil
    }

    // https://www.createwithswift.com/updating-the-users-location-with-core-location-and-swift-concurrency-in-swiftui/

    //MARK: Continuation Object for the User Location
    private var continuation: CheckedContinuation<CLLocation, Error>?

    //MARK: Asynchronously request the current location
    var currentLocation: CLLocation {
        get async throws {
            return try await withCheckedThrowingContinuation { continuation in
                // 1. Set up the continuation object
                self.continuation = continuation
                // 2. Triggers the update of the current location
                manager.requestLocation()
            }
        }
    }
}
