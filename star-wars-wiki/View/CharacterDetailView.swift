//
//  CharacterDetailView.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 05.05.24.
//

import SwiftUI
import SWAPI

struct CharacterDetailView: View {
    var character: PeopleQuery.Data.AllPeople.Person
    var body: some View {
        NavigationView {
            VStack {
                Text(character.birthYear!)
                Text(character.eyeColor!)
                Text(character.gender!)
            }
        }
        
        .navigationTitle(character.name!)
    }
    
}


