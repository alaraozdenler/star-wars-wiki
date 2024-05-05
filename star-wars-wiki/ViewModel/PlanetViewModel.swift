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
    var logger = Logger()
    var pager : AsyncGraphQLQueryPager<PaginationOutput<PlanetsQuery, PlanetsQuery>>
   
    init(planets: [PlanetsQuery.Data.AllPlanets.Planet]) {
        let initialQuery = PlanetsQuery(after: nil, first: 10)
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
                    return PlanetsQuery(after: page.endCursor ?? .none, first: 10)
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
                self.logger.warning("\(error.localizedDescription)")
                break
            }
        }
    }
}
