//
//  CharacterViewModel.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 04.05.24.
//

import Foundation

import Apollo
import SWAPI

@Observable class CharacterViewModel {
    var characters: [PeopleQuery.Data.AllPeople.Person] = []
    
    init(characters: [PeopleQuery.Data.AllPeople.Person]) {
        Network.shared.apollo.fetch(query: PeopleQuery()) {
            result in
            guard let data = try? result.get().data else { return }
            self.characters = data.allPeople?.people as! [PeopleQuery.Data.AllPeople.Person]
        }
    }
}

