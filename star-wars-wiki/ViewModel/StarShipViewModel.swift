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
    private let key = "favShips"
    var showingFavs = false
    var filteredStarships: [StarShipsQuery.Data.AllStarships.Starship] {
        if showingFavs {
            return starships.filter { favoriteStarships.contains($0.name!) }
        } else {
            return starships
        }
    }
    
    init(starships: [StarShipsQuery.Data.AllStarships.Starship]) {
        let initialQuery = StarShipsQuery(after: nil, first: 10)
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
                    return StarShipsQuery(after: page.endCursor ?? .none, first: 10)
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
                self.logger.warning("\(error.localizedDescription)")
                break
            }
        }
        if (UserDefaults.standard.array(forKey: key) != nil) {
            favoriteStarships = UserDefaults.standard.array(forKey: key) as! [String]
        }
        UserDefaults.standard.set(favoriteStarships, forKey: key)
    }
    func addFavorite(ship: String) {
        favoriteStarships.append(ship)
        UserDefaults.standard.set(favoriteStarships, forKey: key)
    }
    func removeFavorite(ship: String) {
        favoriteStarships.remove(at: favoriteStarships.firstIndex(of: ship)!)
        UserDefaults.standard.set(favoriteStarships, forKey: key)
    }
    func sortFavs() {
        showingFavs.toggle()
    }
}
