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
                ForEach(characterViewModel.filteredCharacters, id: \.self) { character in
                    NavigationLink {
                        CharacterDetailView(character: character)
                    } label: {
                        HStack {
                            //highlight if character is a favorite
                            if characterViewModel.favoriteCharacters.contains(character.name!) {
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
                        Button() {
                            //Add character to favorites
                            if characterViewModel.favoriteCharacters.contains(character.name!) {
                                characterViewModel.removeFavorite(character: character.name!)
                            } else {
                                characterViewModel.addFavorite(character: character.name!)
                            }
                        } label: {
                            Label("", systemImage: "star")
                        }
                        .tint(.yellow)
                    }
                    //Load the next page when scrolled down
                    .onAppear() {
                        if (characterViewModel.filteredCharacters.last == character){
                            Task {
                                do {
                                    if (await characterViewModel.pager.canLoadNext) {
                                        try await characterViewModel.pager.loadNext()
                                    }
                                }
                                catch {
                                    characterViewModel.logger.log("\(error.localizedDescription)")
                                }
                            }
                        }
                    }
                }
            }
            //button to filter favorites
            .toolbar {
                Button {
                    characterViewModel.sortFavs()
                } label: {
                    if characterViewModel.showingFavs {
                        Label("", systemImage: "star.fill")
                    } else {
                        Label("", systemImage: "star")
                    }
                }
            }
            .navigationTitle("Characters")
            .onAppear() {
                Task {
                    await characterViewModel.pager.fetch()
                }
            }
        }
    }
}
