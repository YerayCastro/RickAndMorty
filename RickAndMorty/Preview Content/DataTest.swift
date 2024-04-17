//
//  DataTest.swift
//  RickAndMorty
//
//  Created by Yery Castro on 28/3/24.
//

import Foundation

extension Character {
    static let test = Character(id: 1,
                                name: "Rick Sanchez",
                                status: .alive,
                                species: "Human",
                                type: "",
                                gender: .male,
                                origin: Location(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
                                location: Location(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
                                image: URL(fileURLWithPath:"https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
                                episode: [
                                    "https://rickandmortyapi.com/api/episode/1",
                                    "https://rickandmortyapi.com/api/episode/2"
                                  ], 
                                url: "https://rickandmortyapi.com/api/character/1",
                                created: "2017-11-04T18:48:46.250Z")
}

extension Locations {
    static let preview = Locations(id: 1,
                                name: "Earth",
                                type: "Planet",
                                dimension: "Dimension C-137",
                                residents: [
                                    "https://rickandmortyapi.com/api/character/1",
                                    "https://rickandmortyapi.com/api/character/2",
                                  ], 
                                url: "https://rickandmortyapi.com/api/location/1",
                                created: "2017-11-10T12:42:04.162Z")
}

extension Episodes {
    static let test2 = Episodes(id: 28,
                                name: "The Ricklantis Mixup",
                                air_date: "September 10, 2017",
                                episode: "S03E07",
                                characters: [
                                    "https://rickandmortyapi.com/api/character/1",
                                    "https://rickandmortyapi.com/api/character/2"
                                  ], 
                                url: "https://rickandmortyapi.com/api/episode/28",
                                created: "2017-11-10T12:56:36.618Z")
}


extension CharacterVM {
    static let test = CharacterVM(network: DataTest())
}

extension LocationVM {
    static let preview = LocationVM(network: DataTest())
}

extension EpisodeVM {
    static let test2 = EpisodeVM(network: DataTest())
}


struct DataTest: DataInteractor {


    func searchCharacters(page: Int) async throws -> [Character] {
        // Este es un ejemplo. Deberías ajustar la solicitud según los requerimientos de tu API de búsqueda.
        let request = URLRequest.getCharactersRequest(page: page)
        let data = try Data(contentsOf: request.url!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormat)
        let response = try decoder.decode(DTOCharacter.self, from: data)
        return response.results
    }
    
    func getCharacter(page: Int) async throws -> [Character] {
        let request = URLRequest.getCharactersRequest(page: page)
        let data = try Data(contentsOf: request.url!)
        let response = try JSONDecoder().decode(DTOCharacter.self, from: data)
        return response.results
    }
    
    func getLocation(page: Int) async throws -> [Locations] {
        let request = URLRequest.getLocationsRequest(page: page)
        let data = try Data(contentsOf: request.url!)
        let response = try JSONDecoder().decode(DTOLocation.self, from: data)
        return response.results
    }
    func searchLocations(page: Int) async throws -> [Locations] {
        // Este es un ejemplo. Deberías ajustar la solicitud según los requerimientos de tu API de búsqueda.
        let request = URLRequest.getLocationsRequest(page: page)
        let data = try Data(contentsOf: request.url!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormat)
        let response = try decoder.decode(DTOLocation.self, from: data)
        return response.results
    }
    
    func getEpisode(page: Int) async throws -> [Episodes] {
        let request = URLRequest.getEpisodesRequest(page: page)
        let data = try Data(contentsOf: request.url!)
        let response = try JSONDecoder().decode(DTOEpisode.self, from: data)
        return response.results
    }
    
    func searchEpisodes(page: Int) async throws -> [Episodes] {
        // Este es un ejemplo. Deberías ajustar la solicitud según los requerimientos de tu API de búsqueda.
        let request = URLRequest.getEpisodesRequest(page: page)
        let data = try Data(contentsOf: request.url!)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.dateFormat)
        let response = try decoder.decode(DTOEpisode.self, from: data)
        return response.results
    }
    
    
}
    
    
    
    let docURL = URL.documentsDirectory.appending(path: "rickymorty.json")
    

    let url = Bundle.main.url(forResource: "testCharacters", withExtension: "json")!
    let urlLoc = Bundle.main.url(forResource: "testLocations", withExtension: "json")!
    let urlEpis = Bundle.main.url(forResource: "testEpisodes", withExtension: "json")!
    
    



