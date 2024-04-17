//
//  Character.swift
//  RickAndMorty
//
//  Created by Yery Castro on 28/3/24.
//

import Foundation


struct DTOCharacter: Codable {
    let info: Info
    let results: [Character]
}

// MARK: - Info
struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Character: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let status: Status
    let species, type: String
    let gender: Gender
    let origin: Location
    let location: Location
    let image: URL
    let episode: [String]
    let url: String
    let created: String
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
    case genderless = "Genderless"
}

// MARK: - Location
struct Location: Codable, Hashable {
    let name: String
    let url: String
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
