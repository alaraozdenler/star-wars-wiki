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
                        VStack (alignment: .leading){
                            Text(starship.name!).font(.headline)
                            Text(String((starship.filmConnection?.films!.endIndex)!) + " films").font(.subheadline)
                        }
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
            }.onAppear() {
                Task {
                    await starshipViewModel.pager.fetch()
                }
            }
        }
    }
}


