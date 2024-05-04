//
//  CharactersView.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 03.05.24.
//

import SwiftUI

struct CharactersView: View {
    @Bindable var characterViewModel: CharacterViewModel
    var body: some View {
        NavigationStack {
            List(characterViewModel.characters, id: \.self) { character in
                NavigationLink {
                    CharacterDetailView(character: character)
                } label :{
                    VStack (alignment: .leading){
                        Text(character.name!).font(.headline)
                        Text(String((character.filmConnection?.films!.endIndex)! + 1) + " films").font(.subheadline)
                    }
                }
            }
            .navigationTitle("Characters")
        }
    }
}

