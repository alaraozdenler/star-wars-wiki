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
                ForEach(characterViewModel.characters, id: \.self) { character in
                    NavigationLink {
                        CharacterDetailView(character: character)
                    } label: {
                        VStack (alignment: .leading){
                            Text(character.name!).font(.headline)
                            Text(String((character.filmConnection?.films!.endIndex)!) + " films").font(.subheadline)
                        }
                    }
                    //Load the next page when scrolled down
                    .onAppear() {
                        if (characterViewModel.characters.last == character){
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
            .navigationTitle("Characters")
            .onAppear() {
                Task {
                    await characterViewModel.pager.fetch()
                }
            }
        }
    }
}
