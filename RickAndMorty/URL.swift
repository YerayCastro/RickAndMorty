//
//  URL.swift
//  Employees
//
//  Created by Yery Castro on 29/2/24.
//

import Foundation

let prod = URL(string: "https://rickandmortyapi.com/api/")!
let api = prod

extension URL {
    static let urlCharacters = api.appending(path: "character")
    static let urlLocations = api.appending(path: "location")
    static let urlEpisodes = api.appending(path: "episode")
}
