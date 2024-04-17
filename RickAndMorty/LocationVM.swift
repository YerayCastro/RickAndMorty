//
//  LocationVM.swift
//  RickAndMorty
//
//  Created by Yery Castro on 31/3/24.
//

import Foundation


final class LocationVM: ObservableObject {
    let network: DataInteractor
    
    @Published var locations: [Locations] = []
    @Published var currentPage = 1
    @Published var currentCount = 1
    @Published var search: String = ""
    @Published var info: Info?
    @Published var nextPageURL: URL? = URL(string: "https://rickandmortyapi.com/api/character")
    
    
    init(network: DataInteractor = Network()) {
        self.network = network
        Task { await getLocations2() }
    }
    
    func getLocations2() async {
        do {
            let locs = try await network.getLocation(page: currentPage)
            await MainActor.run {
                locations += locs
            }
        } catch {
            await MainActor.run {
                print(error.localizedDescription)
            }
        }
    }
    func ultimoItem(location: Locations) -> Bool {
        locations.last?.id == location.id
    }
    
    func siguientePagina(location: Locations) {
        if ultimoItem(location: location) {
            currentPage += 1
            Task {
                search.isEmpty ? await getLocations2() : await buscarLocations()
            }
        }
    }
    func buscarLocations() async {
        guard !search.isEmpty else {
            await MainActor.run {
                locations.removeAll()
            }
            currentPage = 1
            await getLocations2()
            return
        }
        
        do {
            let location = try await network.getLocation(page: currentPage)
            await MainActor.run {
                if currentPage == 1 {
                    locations.removeAll()
                }
                locations += location
            }
        } catch {
            print(error)
        }
    }
    
    func fetchLocations() async {
        // Define la URL de la API
        guard let url = URL(string: "https://rickandmortyapi.com/api/location") else { return }
        
        do {
            // Realiza la solicitud a la API
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decodifica la respuesta JSON a tu modelo de datos Swift
            let decodedResponse = try JSONDecoder().decode(DTOLocation.self, from: data)
            
            // Actualiza tus datos publicados con la respuesta
            DispatchQueue.main.async {
                self.locations = decodedResponse.results
            }
        } catch {
            // Maneja cualquier error que ocurra durante la solicitud o la decodificación
            print("Error al cargar los personajes: \(error)")
        }
    }
    func loadMoreLocationsIfNeeded(currentLocation location: Locations?) async {
        guard let location = location, let lastLocation = locations.last, location.id == lastLocation.id else { return }
        await loadMoreCharacters()
    }
    
    func loadMoreCharacters() async {
        guard let nextPageURL = nextPageURL else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: nextPageURL)
            let decodedResponse = try JSONDecoder().decode(DTOLocation.self, from: data)
            DispatchQueue.main.async {
                let newLocations = decodedResponse.results.filter { newLocation in
                    !self.locations.contains(where: { $0.id == newLocation.id })
                }
                self.locations += newLocations
                self.nextPageURL = URL(string: decodedResponse.info.next ?? "")
            }
        } catch {
            print("Error loading more characters: \(error)")
        }
    }
}
