//
//  ListLayout.swift
//  Moonshot
//
//  Created by Pavel Bartashov on 29/9/2024.
//

import SwiftUI

struct ListLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        List(missions) { mission in
            NavigationLink {
                MissionView(mission: mission, astronauts: astronauts)
            } label: {
                HStack {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
                    
                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.lightBackground)
                }
                .clipShape(.rect(cornerRadius: 10))
            }
            .listRowBackground(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightBackground)
            )
        }
        .listStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        ListLayout(missions: missions, astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
