//
//  UserProvider.swift
//  SwiftDataProject
//
//  Created by Pavel Bartashov on 7/10/2024.
//

import Foundation
import SwiftData

struct UserProvider {
    
    let context: ModelContext
    
    @MainActor
    func fetchUsers() async throws {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let users = try decoder.decode([User].self, from: data)
        
        users.forEach {
            context.insert($0)
        }
    }
}
