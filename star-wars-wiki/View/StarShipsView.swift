//
//  StarShipsView.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 03.05.24.
//

import SwiftUI

struct StarShipsView: View {
    @Bindable var starShipViewModel: StarShipViewModel
    var body: some View {
        NavigationStack {
            List(starShipViewModel.starShips, id: \.self) { starShip in
                NavigationLink {
                    StarShipDetailView(starShip: starShip)
                } label: {
                    VStack (alignment: .leading){
                        Text(starShip.name!).font(.headline)
                        Text(String((starShip.filmConnection?.films!.endIndex)!) + " films").font(.subheadline)
                    }
                }
            }
            .navigationTitle("Star Ships")
        }
    }
}

