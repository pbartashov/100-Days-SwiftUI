//
//  GridLayout.swift
//  Moonshot
//
//  Created by Pavel Bartashov on 29/9/2024.
//

import SwiftUI

struct GridLayout: View {
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        VStack {
                            Image(mission.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                                .accessibilityHidden(true)
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                            .accessibilityElement(children: .combine)
                            .accessibilityHint("Tap to learn more")
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
        .navigationDestination(for: Mission.self) { mission in
            MissionView(mission: mission, astronauts: astronauts)
            
        }
    }
}

#Preview {
    NavigationStack {
        let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        GridLayout(missions: missions, astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
