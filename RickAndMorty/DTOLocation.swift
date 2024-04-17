//
//  DTOEpisode.swift
//  RickAndMorty
//
//  Created by Yery Castro on 31/3/24.
//

import Foundation


// MARK: - DTOLocation
struct DTOLocation: Codable {
    let info: InfoLocation
    let results: [Locations]
}

// MARK: - Info
struct InfoLocation: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Locations: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
