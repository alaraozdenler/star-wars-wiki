//
//  MainView.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 03.05.24.
//

import SwiftUI
import LocalAuthentication

struct MainView: View {
    @State private var characterViewModel = CharacterViewModel(characters: [])
    @State private var starshipViewModel = StarShipViewModel(starships: [])
    @State private var planetViewModel = PlanetViewModel(planets: [])
    @State var authentication = Authentication()
    
    
    var body: some View {
        ZStack {
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
        .blur(radius: (authentication.isUnlocked ? 0 : 15)).allowsHitTesting(authentication.isUnlocked ? true : false)
        
        .onAppear {
            Task.detached {await authentication.authenticate()}
        }
    }
}

#Preview {
    MainView()
}
