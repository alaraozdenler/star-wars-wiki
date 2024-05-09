//
//  MainView.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 03.05.24.
//

import SwiftUI
import LocalAuthentication
import SWAPI

struct MainView: View {
    @State private var characterViewModel = WikiViewModel(key: "favoriteChars")
        {after, first in PeopleQuery(after: after, first: first)}
        hasNextPage: { data in data.allPeople?.pageInfo.hasNextPage ?? false}
        getEndCursor: { data in data.allPeople?.pageInfo.endCursor}
        getEntries: {page in (page.allPeople?.people as? [PeopleQuery.Data.AllPeople.Person])}
        getID: {person in person.id}
    
    @State private var starshipViewModel = WikiViewModel(key: "favoriteShips")
        {after, first in StarShipsQuery(after: after, first: first)}
        hasNextPage: { data in data.allStarships?.pageInfo.hasNextPage ?? false}
        getEndCursor: { data in data.allStarships?.pageInfo.endCursor}
        getEntries: { page in (page.allStarships?.starships as? [StarShipsQuery.Data.AllStarships.Starship]) }
        getID: { ship in ship.id }
    
    @State private var planetViewModel = WikiViewModel(key: "favoritePlanets")
        {after, first in PlanetsQuery(after: after, first: first)}
        hasNextPage: { data in data.allPlanets?.pageInfo.hasNextPage ?? false}
        getEndCursor: { data in data.allPlanets?.pageInfo.endCursor}
        getEntries: { page in (page.allPlanets?.planets as? [PlanetsQuery.Data.AllPlanets.Planet]) }
        getID: { planet in planet.id }
            
    @State var authentication = Authentication()
    
    var body: some View {
        ZStack {
            TabView {
                WikiView(title: "Characters", wikiListViewModel: characterViewModel)
                    { entry in CharacterDetailView(character: entry) }
                    getEntryName: { character in character.name ?? ""}
                    getFilmCount: { character in character.filmConnection?.films?.count ?? 0}
                    .tabItem {
                        Label("Characters", systemImage: "person.3")
                    }
                
                WikiView(title: "Starships", wikiListViewModel: starshipViewModel)
                    { entry in StarShipDetailView(starship: entry) }
                    getEntryName: { ship in ship.name ?? ""}
                    getFilmCount: { ship in ship.filmConnection?.films?.count ?? 0}
                    .tabItem {
                        Label("Starships", systemImage: "airplane")
                    }
                
                WikiView(title: "Planets", wikiListViewModel: planetViewModel)
                    { entry in PlanetDetailView(planet: entry) }
                    getEntryName: { planet in planet.name ?? ""}
                    getFilmCount: { planet in planet.filmConnection?.films?.count ?? 0}
                    .tabItem {
                        Label("Planets", systemImage: "globe.europe.africa")
                    }
            }
        }
        //Blur the screen and disable everything while the app is locked
        .blur(radius: (authentication.isUnlocked ? 0 : 15)).allowsHitTesting(authentication.isUnlocked ? true : false)
        
        //Ask for authentication when app is launched
        .onAppear {
            Task { await authentication.authenticate() }
        }
    }
}

#Preview {
    MainView()
}
