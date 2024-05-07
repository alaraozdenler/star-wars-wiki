//
//  StarShipViewModel.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 05.05.24.
//

import Foundation
import Apollo
import ApolloPagination
import SWAPI
import os

@Observable class StarShipViewModel{
    var starships: [StarShipsQuery.Data.AllStarships.Starship] = []
    var favoriteStarships: [String] = []
    var logger = Logger()
    var pager : AsyncGraphQLQueryPager<PaginationOutput<StarShipsQuery, StarShipsQuery>>
    var loadedAllPages = false
    private let key = "favShips"
    var showingFavorites = false
    init(starships: [StarShipsQuery.Data.AllStarships.Starship]) {
        let initialQuery = StarShipsQuery(after: nil, first: 8)
        pager = AsyncGraphQLQueryPager(
            client: Network.shared.apollo,
            initialQuery: initialQuery,
            extractPageInfo: { data in
                CursorBasedPagination.Forward(
                    hasNext: data.allStarships?.pageInfo.hasNextPage ?? false,
                    endCursor: data.allStarships?.pageInfo.endCursor
                )
            },
            pageResolver: { page, paginationDirection in
                switch paginationDirection {
                case .next:
                    return StarShipsQuery(after: page.endCursor ?? .none, first: 8)
                case .previous:
                    return nil
                }
            }
        )
        pager.subscribe { result  in
            switch result {
            case .success(let data):
                //initial fetch
                if self.starships.isEmpty {
                    self.starships = data.0.initialPage.allStarships?.starships as! [StarShipsQuery.Data.AllStarships.Starship]
                }
                //fetch next pages
                else if !data.0.nextPages.isEmpty {
                    let nextPages = data.0.nextPages
                    self.starships += nextPages[nextPages.endIndex - 1].allStarships?.starships as! [StarShipsQuery.Data.AllStarships.Starship]
                }
            case .failure(let error):
                self.logger.warning("\(error)")
                break
            }
        }
        if (UserDefaults.standard.array(forKey: key) != nil) {
            favoriteStarships = UserDefaults.standard.array(forKey: key) as! [String]
        }
        UserDefaults.standard.set(favoriteStarships, forKey: key)
    }
    func loadInitialPage() async {
        await pager.fetch()
    }
    
    func loadNextPage() async {
        do {
            if (await pager.canLoadNext) {
                try await pager.loadNext()
            } else {
                loadedAllPages = true
            }
        }
        catch {
            logger.log("\(error)")
        }
    }
    
    func addFavorite(starship: StarShipsQuery.Data.AllStarships.Starship) {
        favoriteStarships.append(starship.name!)
        UserDefaults.standard.set(favoriteStarships, forKey: key)
    }
    
    func removeFavorite(starship: StarShipsQuery.Data.AllStarships.Starship) {
        if hasFavorite(starship: starship) {
            favoriteStarships.remove(at: favoriteStarships.firstIndex(of: starship.name!)!)
            UserDefaults.standard.set(favoriteStarships, forKey: key)
        }
    }
    
    func hasFavorite(starship: StarShipsQuery.Data.AllStarships.Starship) -> Bool {
        return favoriteStarships.contains(starship.name!)
    }
    
    func toggleFavorite(starship: StarShipsQuery.Data.AllStarships.Starship) {
        if hasFavorite(starship: starship) {
            favoriteStarships.remove(at: favoriteStarships.firstIndex(of: starship.name!)!)
            UserDefaults.standard.set(favoriteStarships, forKey: key)
        } else {
            addFavorite(starship: starship)
        }
    }
    
    func getStarships() -> [StarShipsQuery.Data.AllStarships.Starship] {
        if showingFavorites {
            return starships.filter(hasFavorite)
        } else {
            return starships
        }
    }
    
    func filterFavorites() {
        showingFavorites.toggle()
    }
}
