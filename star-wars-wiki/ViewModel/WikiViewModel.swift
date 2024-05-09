//
//  WikiViewModel.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 09.05.24.
//

import Foundation
import Combine
import Apollo
import ApolloPagination
import SWAPI
import os

@Observable class WikiViewModel<P: GraphQLQuery, E> {
    var pager : AsyncGraphQLQueryPager<PaginationOutput<P,P>>
    var pages : [P.Data?] = []
    
    var favorites: [String] = []
    var pagesRemaining = true
    var filterFavorites = false
    private var key: String
    var logger = Logger()
    
    var hasNextPage: (P.Data) -> Bool
    var getEndCursor: (P.Data) -> String?
    var getEntries: (P.Data) -> [E]?
    var createQuery: (GraphQLNullable<String>, GraphQLNullable<Int>) -> P
    var getID: (E) -> String
    
    init(key: String,
         createQuery: @escaping (GraphQLNullable<String>, GraphQLNullable<Int>) -> P,
         hasNextPage: @escaping (P.Data) -> Bool,
         getEndCursor: @escaping (P.Data) -> String?,
         getEntries: @escaping (P.Data) -> [E]?,
         getID: @escaping (E) -> String) {
        
        self.key = key
        self.createQuery = createQuery
        self.hasNextPage = hasNextPage
        self.getEndCursor = getEndCursor
        self.getEntries = getEntries
        self.getID = getID
        
        let initialQuery = createQuery(nil, 10)
        pager = AsyncGraphQLQueryPager(
            client: Network.shared.client,
            initialQuery: initialQuery,
            extractPageInfo: { data in
                return CursorBasedPagination.Forward(
                    hasNext: hasNextPage(data),
                    endCursor: getEndCursor(data)
                )
            },
            pageResolver: { page, paginationDirection in
                switch paginationDirection {
                case .next:
                    return createQuery(page.endCursor ?? .none, 10)
                case .previous:
                    return nil
                }
            }
        )
        //Make favorites persistent
        if (UserDefaults.standard.array(forKey: key) != nil) {
            favorites = UserDefaults.standard.array(forKey: key) as! [String]
        }
        UserDefaults.standard.set(favorites, forKey: key)
        
        
        pager.subscribe { result in
            switch result {
            case .success(let data):
                self.pages = [data.0.initialPage]
                self.pages.append(contentsOf: data.0.nextPages)
                self.pagesRemaining = self.hasNextPage(data.0.nextPages.isEmpty ? data.0.initialPage : data.0.nextPages.last!)
                
            case .failure(let error):
                self.logger.warning("Error loading new page: \(error)")
                break
            }
        }
    }
    
    func loadPage() {
        //Initial fetch
        if pages.isEmpty {
            Task { await pager.fetch() }
            //Load next pages
        } else if pagesRemaining {
            Task {
                do {
                    try await pager.loadNext(cachePolicy: .returnCacheDataAndFetch)
                }
                catch {
                    logger.error("Error loading new page: \(error)")
                }
            }
        } else {
            logger.log("Loaded all pages!")
        }
    }
    
    func addFavorite(entry: E) {
        favorites.append(getID(entry))
        UserDefaults.standard.set(favorites, forKey: key)
    }
    
    func removeFavorite(entry: E) {
        if hasFavorite(entry: entry) {
            favorites.remove(at: favorites.firstIndex(of:getID(entry))!)
            UserDefaults.standard.set(favorites, forKey: key)
        }
    }
    
    func hasFavorite(entry: E) -> Bool {
        return favorites.contains(getID(entry))
    }
    
    //If entry is already a favorite then remove, else add as a favorite
    func toggleFavorite(entry: E) {
        if hasFavorite(entry: entry) {
            favorites.remove(at: favorites.firstIndex(of: getID(entry))!)
            UserDefaults.standard.set(favorites, forKey: key)
        } else {
            addFavorite(entry: entry)
        }
    }
    
    func getAllEntries() -> [E] {
        let entries = pages.flatMap { page in (page != nil ? (self.getEntries(page!) ?? []) : []) }
        return filterFavorites ? entries.filter(hasFavorite) : entries
    }
}
