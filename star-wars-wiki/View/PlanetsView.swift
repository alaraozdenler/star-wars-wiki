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
                ForEach(planetViewModel.filteredPlanets, id: \.self) { planet in
                    NavigationLink {
                        PlanetDetailView(planet: planet)
                    } label: {
                        HStack {
                            //highlight if planet is a favorite
                            if planetViewModel.favoritePlanets.contains(planet.name!) {
                                Image(systemName: "star.fill").font(.caption)
                                    .foregroundStyle(.yellow)
                                    .background() {
                                        Circle().fill(.white).frame(width: 20, height: 20)
                                            .shadow(color: .yellow,radius: 5 )
                                    }
                            }
                            VStack (alignment: .leading){
                                Text(planet.name!).font(.headline)
                                Text(String((planet.filmConnection?.films!.endIndex)!) + " films").font(.subheadline)
                            }
                        }
                    }
                    .swipeActions {
                        Button() {
                            //Add planet to favorites
                            if planetViewModel.favoritePlanets.contains(planet.name!) {
                                planetViewModel.removeFavorite(planet: planet.name!)
                            } else {
                                planetViewModel.addFavorite(planet: planet.name!)
                            }
                        } label: {
                            Label("", systemImage: "star")
                        }.tint(.yellow)
                    }
                    //Load the next page when scrolled down
                    .onAppear() {
                        if (planetViewModel.filteredPlanets.last == planet) {
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
                }
            }
            //button to filter favorites
            .toolbar {
                Button {
                    planetViewModel.sortFavs()
                } label: {
                    if planetViewModel.showingFavs {
                        Label("", systemImage: "star.fill")
                    } else {
                        Label("", systemImage: "star")
                    }
                }
            }
            .navigationTitle("Planets")
            .onAppear() {
                Task {
                    await planetViewModel.pager.fetch()
                }
            }
        }
    }
}

