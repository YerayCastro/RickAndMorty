//
//  DTOEpisode.swift
//  RickAndMorty
//
//  Created by Yery Castro on 1/4/24.
//

import Foundation

// MARK: - DTOEpisodes
struct DTOEpisode: Codable {
    let info: InfoEpisode
    let results: [Episodes]
}

// MARK: - Info
struct InfoEpisode: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Episodes: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
