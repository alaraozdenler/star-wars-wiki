//
//  StarShipsView.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 03.05.24.
//

import SwiftUI
import os

struct StarShipsView: View {
    @Bindable var starshipViewModel: StarShipViewModel
    @State var loaded = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(starshipViewModel.getStarships(), id: \.self) { starship in
                    NavigationLink {
                        StarShipDetailView(starship: starship)
                    } label: {
                        HStack {
                            //Highlight if starship is a favorite
                            if starshipViewModel.hasFavorite(starship: starship) {
                                Image(systemName: "star.fill").font(.caption)
                                    .foregroundStyle(.yellow)
                                    .background() {
                                        Circle().fill(.white).frame(width: 20, height: 20)
                                            .shadow(color: .yellow,radius: 5 )
                                    }
                            }
                            VStack (alignment: .leading){
                                Text(starship.name!).font(.headline)
                                Text(String((starship.filmConnection?.films!.endIndex)!) + " films").font(.subheadline)
                            }
                        }
                    }
                    .swipeActions {
                        Button() {
                            //Add starship to favorites or remove if it is already in favorites
                            starshipViewModel.toggleFavorite(starship: starship)
                        } label: {
                            Label("", systemImage: "star")
                        }
                        .tint(.yellow)
                    }
                    //Load the next page when scrolled all the way down to the last item on the list
                    .onAppear() {
                        if (!starshipViewModel.loadedAllPages && starshipViewModel.starships.last == starship){
                            Task { await starshipViewModel.loadNextPage() }
                        }
                    }
                }
            }
            //Button to filter favorites
            .toolbar {
                Button {
                    starshipViewModel.filterFavorites()
                } label: {
                    if starshipViewModel.showingFavorites {
                        Label("", systemImage: "star.fill")
                    } else {
                        Label("", systemImage: "star")
                    }
                }
            }
            .navigationTitle("Starships")
            .onAppear() {
                Task { await starshipViewModel.loadInitialPage()}
            }
        }
    }
}
