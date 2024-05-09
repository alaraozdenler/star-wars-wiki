//
//  Network.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 05.05.24.
//

import Foundation
import Apollo
import ApolloSQLite
import os

class Network {
    static let shared = Network()
    private let url = "https://swapi-graphql.netlify.app/.netlify/functions/index"
    private let logger = Logger()
    
    private var store : ApolloStore
    private var cache : NormalizedCache
    private var networkTransport : NetworkTransport
    
    private(set) var client: ApolloClient
    
    init() {
        do {
            let documentsPath = NSSearchPathForDirectoriesInDomains(
                .documentDirectory,
                .userDomainMask,
                true
            ).first!
            
            let documentsURL = URL(fileURLWithPath: documentsPath)
            let sqliteFileURL = documentsURL.appendingPathComponent("test_apollo_db.sqlite")
            
            self.cache = try SQLiteNormalizedCache(fileURL: sqliteFileURL)
        }
        catch {
            logger.error("Error setting up SQLite Cache: \(error)")
            self.cache = InMemoryNormalizedCache()
        }
        self.store = ApolloStore(cache: cache)
            
        self.networkTransport = RequestChainNetworkTransport(interceptorProvider: DefaultInterceptorProvider(store: store),
                                                                 endpointURL: URL(string: url)!)
        self.client = ApolloClient(networkTransport: networkTransport, store: store)

    }
}
