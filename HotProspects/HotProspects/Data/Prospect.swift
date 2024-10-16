//
//  Prospect.swift
//  HotProspects
//
//  Created by Pavel Bartashov on 16/10/2024.
//

import Foundation
import SwiftData

@Model
final class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var date: Date
    
    init(name: String, emailAddress: String, date: Date = .now, isContacted: Bool = false) {
        self.name = name
        self.emailAddress = emailAddress
        self.date = date
        self.isContacted = isContacted
    }
}

extension Prospect {
    static let `default` = Prospect(name: "Anonymous", emailAddress: "you@yoursite.com")
}
