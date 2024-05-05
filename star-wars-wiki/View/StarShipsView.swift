//
//  StarShipsView.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 03.05.24.
//

import SwiftUI

struct StarShipsView: View {
    @Bindable var starshipViewModel: StarShipViewModel
    var body: some View {
        NavigationStack {
            List(starshipViewModel.starships, id: \.self) { starship in
                NavigationLink {
                    StarShipDetailView(starship: starship)
                } label: {
                    VStack (alignment: .leading){
                        Text(starship.name!).font(.headline)
                        Text(String((starship.filmConnection?.films!.endIndex)!) + " films").font(.subheadline)
                    }
                }
            }
            .navigationTitle("Starships")
        }
    }
}

