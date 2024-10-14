//
//  MissionView.swift
//  Moonshot
//
//  Created by Pavel Bartashov on 27/9/2024.
//


import SwiftUI

struct MissionView: View {
    
    
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.imageName)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.vertical)
                    .accessibilityHidden(true)
                
                Text(mission.completeFormattedLaunchDate)
                
                VStack(alignment: .leading) {
                    CustomDivider()
                    
                    Text("Mission highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                    
                    CustomDivider()
                    
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                
                AsronautListView(crew: crew)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    NavigationStack {
        MissionView(
            mission: missions.last ??
            Mission(
                id: 1, launchDate: Date(),
                crew: [
                    Mission.CrewRole(name: "", role: "")
                ],
                description: ""
            ),
            astronauts: astronauts
        )
        .preferredColorScheme(.dark)
    }
}
