//
//  PlanetViewModel.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 05.05.24.
//

import Foundation
import Apollo
import ApolloPagination
import SWAPI
import os

@Observable class PlanetViewModel {
    var planets: [PlanetsQuery.Data.AllPlanets.Planet] = []
    var favoritePlanets: [String] = []
    var logger = Logger()
    var pager : AsyncGraphQLQueryPager<PaginationOutput<PlanetsQuery, PlanetsQuery>>
    var loadedAllPages = false
    private let key = "favPlanets"
    var showingFavorites = false
    
    init(planets: [PlanetsQuery.Data.AllPlanets.Planet]) {
        let initialQuery = PlanetsQuery(after: nil, first: 8)
        pager = AsyncGraphQLQueryPager(
            client: Network.shared.apollo,
            initialQuery: initialQuery,
            extractPageInfo: { data in
                CursorBasedPagination.Forward(
                    hasNext: data.allPlanets?.pageInfo.hasNextPage ?? false,
                    endCursor: data.allPlanets?.pageInfo.endCursor
                )
            },
            pageResolver: { page, paginationDirection in
                switch paginationDirection {
                case .next:
                    return PlanetsQuery(after: page.endCursor ?? .none, first: 8)
                case .previous:
                    return nil
                }
            }
        )
        pager.subscribe { result in
            switch result {
            case .success(let data):
                //initial fetch
                if self.planets.isEmpty {
                    self.planets = data.0.initialPage.allPlanets?.planets as! [PlanetsQuery.Data.AllPlanets.Planet]
                }
                //fetch next pages
                else if !data.0.nextPages.isEmpty {
                    let nextPages = data.0.nextPages
                    self.planets += nextPages[nextPages.endIndex - 1].allPlanets?.planets as! [PlanetsQuery.Data.AllPlanets.Planet]
                }
            case .failure(let error):
                self.logger.warning("\(error)")
                break
            }
        }
        if (UserDefaults.standard.array(forKey: key) != nil) {
            favoritePlanets = UserDefaults.standard.array(forKey: key) as! [String]
        }
        UserDefaults.standard.set(favoritePlanets, forKey: key)
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
    
    func addFavorite(planet: PlanetsQuery.Data.AllPlanets.Planet) {
        favoritePlanets.append(planet.name!)
        UserDefaults.standard.set(favoritePlanets, forKey: key)
    }
    
    func removeFavorite(planet: PlanetsQuery.Data.AllPlanets.Planet) {
        if hasFavorite(planet: planet) {
            favoritePlanets.remove(at: favoritePlanets.firstIndex(of: planet.name!)!)
            UserDefaults.standard.set(favoritePlanets, forKey: key)
        }
    }
    
    func hasFavorite(planet: PlanetsQuery.Data.AllPlanets.Planet) -> Bool {
        return favoritePlanets.contains(planet.name!)
    }
    
    func toggleFavorite(planet: PlanetsQuery.Data.AllPlanets.Planet) {
        if hasFavorite(planet: planet) {
            favoritePlanets.remove(at: favoritePlanets.firstIndex(of: planet.name!)!)
            UserDefaults.standard.set(favoritePlanets, forKey: key)
        } else {
            addFavorite(planet: planet)
        }
    }
    
    func getPlanets() -> [PlanetsQuery.Data.AllPlanets.Planet] {
        if showingFavorites {
            return planets.filter(hasFavorite)
        } else {
            return planets
        }
    }
    
    func filterFavorites() {
        showingFavorites.toggle()
    }
}


