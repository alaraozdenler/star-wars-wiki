//
//  StarShipViewModel.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 05.05.24.
//

import Foundation
import Apollo
import SWAPI


@Observable class StarShipViewModel {
    var starShips: [StarShipsQuery.Data.AllStarships.Starship] = []
    
    init(starShips: [StarShipsQuery.Data.AllStarships.Starship]) {
        Network.shared.apollo.fetch(query: StarShipsQuery()) {
            result in
            guard let data = try? result.get().data else { return }
            self.starShips = data.allStarships?.starships as! [StarShipsQuery.Data.AllStarships.Starship]
        }
    }
}

