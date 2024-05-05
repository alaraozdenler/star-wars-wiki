//
//  PlanetsView.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 03.05.24.
//

import SwiftUI

struct PlanetsView: View {
    @Bindable var planetViewModel: PlanetViewModel
    var body: some View {
        NavigationStack {
            List(planetViewModel.planets, id: \.self) { planet in
                NavigationLink {
                    PlanetDetailView(planet: planet)
                } label: {
                    VStack (alignment: .leading){
                        Text(planet.name!).font(.headline)
                        Text(String((planet.filmConnection?.films!.endIndex)!) + " films").font(.subheadline)
                    }
                }
            }
            .navigationTitle("Planets")
        }
    }
}

