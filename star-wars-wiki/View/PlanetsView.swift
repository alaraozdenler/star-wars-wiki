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
            List {
                ForEach(planetViewModel.planets, id: \.self) { planet in
                    NavigationLink {
                        PlanetDetailView(planet: planet)
                    } label: {
                        VStack (alignment: .leading){
                            Text(planet.name!).font(.headline)
                            Text(String((planet.filmConnection?.films!.endIndex)!) + " films").font(.subheadline)
                        }
                    }
                    //Load the next page when scrolled down
                    .onAppear() {
                        if (planetViewModel.planets.last == planet) {
                            Task {
                                do {
                                    if (await planetViewModel.pager.canLoadNext) {
                                        try await planetViewModel.pager.loadNext()
                                    }
                                }
                                catch {
                                    planetViewModel.logger.log("\(error.localizedDescription)")
                                }
                                
                            }
                        }
                    }
                    .navigationTitle("Planets")
                }
            }
            .onAppear() {
                Task {
                    await planetViewModel.pager.fetch()
                }
            }
        }
    }
    
}
