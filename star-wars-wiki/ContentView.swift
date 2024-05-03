//
//  ContentView.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 03.05.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            CharactersView()
                 .tabItem {
                     Label("Characters", systemImage: "person.3")
                 }
             StarShipsView()
                 .tabItem {
                     Label("Star Ships", systemImage: "airplane")
                 }
             PlanetsView()
                 .tabItem {
                     Label("Planets", systemImage: "globe.europe.africa")
                 }
        }
    }
}

#Preview {
    ContentView()
}
