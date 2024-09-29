//
//  CrewMember.swift
//  Moonshot
//
//  Created by Pavel Bartashov on 29/9/2024.
//


struct CrewMember {
        let role: String
        let astronaut: Astronaut

        var isCommander: Bool {
            role.contains("Commander")
        }
    }