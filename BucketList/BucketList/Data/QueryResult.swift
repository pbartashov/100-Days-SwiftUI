//
//  QueryResult.swift
//  BucketList
//
//  Created by Pavel Bartashov on 11/10/2024.
//

struct QueryResult: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}

extension Page: Comparable {
    static func <(lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
}

extension Page {
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
}
