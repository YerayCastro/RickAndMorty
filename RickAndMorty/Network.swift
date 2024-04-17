//
//  DataInteractor.swift
//  RickAndMorty
//
//  Created by Yery Castro on 28/3/24.
//

import Foundation

protocol DataInteractor {
    func getCharacter(page: Int) async throws -> [Character]
    func getLocation(page: Int) async throws -> [Locations]
    func getEpisode(page: Int) async throws -> [Episodes]
}

struct Network: DataInteractor {
    func postJSON(request: URLRequest, status: Int = 200) async throws {
        let (_, response) = try await URLSession.shared.getData(request: request)
        if response.statusCode != status {
            throw NetworkError.statusCode(response.statusCode)
        }
    }
    
    func getCharacter(page: Int) async throws -> [Character] {
        let request = URLRequest.getCharactersRequest(page: page)
        let response: DTOCharacter = try await getJSON(request: request, type: DTOCharacter.self)
        return response.results
    }
    
    func searchCharacters(page: Int) async throws -> [Character] {
        let request = URLRequest.getCharactersRequest(page: page)
        let response: DTOCharacter = try await getJSON(request: request, type: DTOCharacter.self)
        return response.results
    }
    
    func getLocation(page: Int) async throws -> [Locations] {
        let request = URLRequest.getLocationsRequest(page: page)
        let response: DTOLocation = try await getJSON(request: request, type: DTOLocation.self)
        return response.results
    }
    
    func searchLocations(page: Int) async throws -> [Locations] {
        let request = URLRequest.getEpisodesRequest(page: page)
        let response: DTOLocation = try await getJSON(request: request, type: DTOLocation.self)
        return response.results
    }
    
    func getEpisode(page: Int) async throws -> [Episodes] {
        let request = URLRequest.getEpisodesRequest(page: page)
        let response: DTOEpisode = try await getJSON(request: request, type: DTOEpisode.self)
        return response.results
    }
    
    func searchEpisodes(page: Int) async throws -> [Episodes] {
        let request = URLRequest.getEpisodesRequest(page: page)
        let response: DTOEpisode = try await getJSON(request: request, type: DTOEpisode.self)
        return response.results
    }
    
}

