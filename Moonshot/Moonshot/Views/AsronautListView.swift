//
//  AsronautListView.swift
//  Moonshot
//
//  Created by Pavel Bartashov on 29/9/2024.
//

import SwiftUI

struct AsronautListView: View {
    let crew: [CrewMember]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        VStack {
                            ZStack(alignment: .topTrailing) {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 104, height: 72)
                                    .clipShape(.capsule)
                                    .overlay (
                                        Capsule()
                                            .strokeBorder(.white, lineWidth: 1)
                                    )

                                if crewMember.isCommander {
                                    Image(systemName: "star.fill")
                                        .foregroundStyle(.yellow)
                                }
                            }

                            VStack {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)

                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    NavigationStack {
        AsronautListView(
            crew: [
                CrewMember(
                    role: "Commander",
                    astronaut: astronauts["grissom"]!
                ),
                CrewMember(
                    role: "Senior Pilot",
                    astronaut: astronauts["white"]!
                ),
                CrewMember(
                    role: "Pilot",
                    astronaut: astronauts["chaffee"]!
                )
            ]
        )
        .preferredColorScheme(.dark)
    }
}
