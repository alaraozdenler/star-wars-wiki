//
//  CharactersView.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 03.05.24.
//

import SwiftUI
import os

struct CharactersView: View {
    @Bindable var characterViewModel: CharacterViewModel
    var body: some View {
        NavigationStack {
            List {
                ForEach(characterViewModel.getCharacters(), id: \.self) { character in
                    NavigationLink {
                        CharacterDetailView(character: character)
                    } label: {
                        HStack {
                            //Highlight if character is a favorite
                            if characterViewModel.hasFavorite(character: character) {
                                Image(systemName: "star.fill").font(.caption)
                                    .foregroundStyle(.yellow)
                                    .background() {
                                        Circle().fill(.white).frame(width: 20, height: 20)
                                            .shadow(color: .yellow,radius: 5 )
                                    }
                            }
                            VStack (alignment: .leading){
                                Text(character.name!).font(.headline)
                                Text(String((character.filmConnection?.films!.endIndex)!) + " films").font(.subheadline)
                            }
                        }
                    }
                    .swipeActions {
                        Button {
                            //Add character to favorites or remove if it is already in favorites
                            characterViewModel.toggleFavorite(character: character)
                        } label: {
                            Label("", systemImage: "star")
                        }
                        .tint(.yellow)
                    }
                    //Load the next page when scrolled all the way down to the last item on the list
                    .onAppear() {
                        if (!characterViewModel.loadedAllPages && characterViewModel.characters.last == character){
                            Task { await characterViewModel.loadNextPage() }
                        }
                    }
                }
            }
            //Button to filter favorites
            .toolbar {
                Button {
                    characterViewModel.filterFavorites()
                } label: {
                    if characterViewModel.showingFavorites {
                        Label("", systemImage: "star.fill")
                    } else {
                        Label("", systemImage: "star")
                    }
                }
            }
            .navigationTitle("Characters")
            .onAppear() {
                Task { await characterViewModel.loadInitialPage() }
            }
        }
    }
}
