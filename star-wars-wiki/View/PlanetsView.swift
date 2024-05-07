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
                ForEach(planetViewModel.getPlanets(), id: \.self) { planet in
                    NavigationLink {
                        PlanetDetailView(planet: planet)
                    } label: {
                        HStack {
                            //Highlight if planet is a favorite
                            if planetViewModel.hasFavorite(planet: planet) {
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
                            //Add planet to favorites or remove if it is already in favorites
                            planetViewModel.toggleFavorite(planet: planet)
                        } label: {
                            Label("", systemImage: "star")
                        }
                        .tint(.yellow)
                    }
                    //Load the next page when scrolled all the way down to the last item on the list
                    .onAppear() {
                        if (!planetViewModel.loadedAllPages && planetViewModel.planets.last == planet){
                            Task { await planetViewModel.loadNextPage() }
                        }
                    }
                }
            }
            //Button to filter favorites
            .toolbar {
                Button {
                    planetViewModel.filterFavorites()
                } label: {
                    if planetViewModel.showingFavorites {
                        Label("", systemImage: "star.fill")
                    } else {
                        Label("", systemImage: "star")
                    }
                }
            }
            .navigationTitle("Planets")
            .onAppear() {
                Task { await planetViewModel.loadInitialPage() }
            }
        }
    }
}

