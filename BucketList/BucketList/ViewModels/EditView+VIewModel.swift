//
//  EditView+VIewModel.swift
//  BucketList
//
//  Created by Pavel Bartashov on 11/10/2024.
//

import Foundation

extension EditView {
    
    @Observable
    class ViewModel {
        var location: Location
        var name: String
        var description: String
        var loadingState = LoadingState.loading
        var pages = [Page]()
        
        init(
            location: Location,
            name: String,
            description: String,
            loadingState: LoadingState = LoadingState.loading,
            pages: [Page] = []
        ) {
            self.location = location
            self.name = name
            self.description = description
            self.loadingState = loadingState
            self.pages = pages
        }
        
        func updatedLocation() -> Location {
            var newLocation = location
            newLocation.id = UUID()
            newLocation.name = name
            newLocation.description = description
            
            return newLocation
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                loadingState = .failed
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(QueryResult.self, from: data)
                
                pages = items.query.pages.values.sorted()
                
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
        }
    }
}
