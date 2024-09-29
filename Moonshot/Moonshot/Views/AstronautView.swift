//
//  AstronautView.swift
//  Moonshot
//
//  Created by Pavel Bartashov on 27/9/2024.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView{
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
            .background(.darkBackground)
            .navigationTitle(astronaut.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    NavigationStack {
        AstronautView(astronaut: astronauts["grissom"]!)
            .preferredColorScheme(.dark)
    }
}
