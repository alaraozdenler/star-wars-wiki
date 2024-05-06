//
//  CharacterViewModel.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 04.05.24.
//

import Foundation
import Apollo
import ApolloPagination
import SWAPI
import os

@Observable class CharacterViewModel {
    var characters: [PeopleQuery.Data.AllPeople.Person] = []
    var favoriteCharacters: [String] = []
    var logger = Logger()
    var pager : AsyncGraphQLQueryPager<PaginationOutput<PeopleQuery, PeopleQuery>>
    private let key = "favChars"
    
    init(characters: [PeopleQuery.Data.AllPeople.Person]) {
        let initialQuery = PeopleQuery(after: nil, first: 10)
        pager = AsyncGraphQLQueryPager(
            client: Network.shared.apollo,
            initialQuery: initialQuery,
            extractPageInfo: { data in
                CursorBasedPagination.Forward(
                    hasNext: data.allPeople?.pageInfo.hasNextPage ?? false,
                    endCursor: data.allPeople?.pageInfo.endCursor
                )
            },
            pageResolver: { page, paginationDirection in
                switch paginationDirection {
                case .next:
                    return PeopleQuery(after: page.endCursor ?? .none, first: 10)
                case .previous:
                    return nil
                }
            }
        )
        pager.subscribe { result in
            switch result {
            case .success(let data):
                //initial fetch
                if self.characters.isEmpty {
                    self.characters = data.0.initialPage.allPeople?.people as! [PeopleQuery.Data.AllPeople.Person]
                }
                //fetch next pages
                else if !data.0.nextPages.isEmpty {
                    let nextPages = data.0.nextPages
                    self.characters += nextPages[nextPages.endIndex - 1].allPeople?.people as! [PeopleQuery.Data.AllPeople.Person]
                }
            case .failure(let error):
                self.logger.warning("\(error.localizedDescription)")
                break
            }
        }
        if (UserDefaults.standard.array(forKey: key) != nil) {
            favoriteCharacters = UserDefaults.standard.array(forKey: key) as! [String]
        }
        UserDefaults.standard.set(favoriteCharacters, forKey: key)
    }
    func addFavorite(character: String) {
        favoriteCharacters.append(character)
        UserDefaults.standard.set(favoriteCharacters, forKey: key)
    }
    func removeFavorite(character: String) {
        favoriteCharacters.remove(at: favoriteCharacters.firstIndex(of: character)!)
        UserDefaults.standard.set(favoriteCharacters, forKey: key)
    }
}
