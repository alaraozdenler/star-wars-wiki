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
    var body: some View {
        NavigationStack {
            List {
                ForEach(starshipViewModel.starships, id: \.self) { starship in
                    NavigationLink {
                        StarShipDetailView(starship: starship)
                    } label: {
                        HStack {
                            //highlight if starship is a favorite
                            if starshipViewModel.favoriteStarships.contains(starship.name!) {
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
                            //Add starship to favorites
                            if starshipViewModel.favoriteStarships.contains(starship.name!) {
                                starshipViewModel.removeFavorite(ship: starship.name!)
                            } else {
                                starshipViewModel.addFavorite(ship: starship.name!)
                            }
                            
                        } label: {
                            Label("", systemImage: "star")
                        }.tint(.yellow)
                    }
                    //Load the next page when scrolled down
                    .onAppear() {
                        if (starshipViewModel.starships.last == starship) {
                            Task {
                                do {
                                    if (await starshipViewModel.pager.canLoadNext) {
                                        try await starshipViewModel.pager.loadNext()
                                    }
                                }
                                catch {
                                    starshipViewModel.logger.log("\(error.localizedDescription)")
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Starships")
            }
            .onAppear() {
                Task {
                    await starshipViewModel.pager.fetch()
                }
            }
        }
    }
}


