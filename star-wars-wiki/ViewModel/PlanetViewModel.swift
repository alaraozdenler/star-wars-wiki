//
//  PlanetViewModel.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 05.05.24.
//

import Foundation
import Apollo
import SWAPI


@Observable class PlanetViewModel {
    var planets: [PlanetsQuery.Data.AllPlanets.Planet] = []
    
    init(planets: [PlanetsQuery.Data.AllPlanets.Planet]) {
        Network.shared.apollo.fetch(query: PlanetsQuery()) {
            result in
            guard let data = try? result.get().data else { return }
            self.planets = data.allPlanets?.planets as! [PlanetsQuery.Data.AllPlanets.Planet]
        }
    }
}

