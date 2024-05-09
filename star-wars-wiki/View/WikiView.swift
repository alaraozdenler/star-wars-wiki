//
//  WikiView.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 08.05.24.
//

import SwiftUI
import os
import SWAPI

struct WikiView<P: GraphQLQuery, E: Hashable, DetailView: View>: View {
    let title: String
    @Bindable var wikiListViewModel: WikiViewModel<P, E>
    @ViewBuilder let detailView: (E) -> DetailView
    let getEntryName: (E) -> String
    let getFilmCount: (E) -> Int
    
    
    var body: some View {
        NavigationStack {
            List {
                let entries = wikiListViewModel.getAllEntries()
                ForEach(entries, id: \.self) { entry in
                    NavigationLink {
                        detailView(entry)
                    } label: {
                        HStack {
                            //Highlight if entry is a favorite
                            if wikiListViewModel.hasFavorite(entry: entry) {
                                Image(systemName: "star.fill").font(.caption)
                                    .foregroundStyle(.yellow)
                                    .background() {
                                        Circle().fill(.white).frame(width: 20, height: 20)
                                            .shadow(color: .yellow,radius: 5 )
                                    }
                            }
                            VStack (alignment: .leading){
                                Text(getEntryName(entry)).font(.headline)
                                Text(String(getFilmCount(entry)) + " films").font(.subheadline)
                            }
                        }
                    }
                    //Swipe to add entry to favorites or remove if it is already in favorites
                    .swipeActions {
                        Button {
                            wikiListViewModel.toggleFavorite(entry: entry)
                        } label: {
                            Label("", systemImage: "star")
                        }
                        .tint(.yellow)
                    }
                    //Load the next page if scrolled all the way down to the last item on the list
                    .onAppear {
                        if (entries.last == entry) {
                            wikiListViewModel.loadPage()
                        }
                    }
                }
            }
            //Button to filter favorites
            .toolbar {
                Button {
                    wikiListViewModel.filterFavorites.toggle()
                } label: { Label("", systemImage: wikiListViewModel.filterFavorites ? "star.fill" : "star") }
            }
            .navigationTitle(title)
            .onAppear(perform: wikiListViewModel.loadPage)
        }
    }
}
