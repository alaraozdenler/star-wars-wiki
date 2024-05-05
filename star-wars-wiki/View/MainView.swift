//
//  MainView.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 03.05.24.
//

import SwiftUI

struct MainView: View {
    @State private var characterViewModel = CharacterViewModel(characters: [])
    @State private var starshipViewModel = StarShipViewModel(starships: [])
    @State private var planetViewModel = PlanetViewModel(planets: [])
    var body: some View {
        TabView {
            CharactersView(characterViewModel: characterViewModel)
                .tabItem {
                    Label("Characters", systemImage: "person.3")
                }
            StarShipsView(starshipViewModel: starshipViewModel)
                .tabItem {
                    Label("Starships", systemImage: "airplane")
                }
            PlanetsView(planetViewModel: planetViewModel)
                .tabItem {
                    Label("Planets", systemImage: "globe.europe.africa")
                }
        }
    }
}

#Preview {
    MainView()
}
