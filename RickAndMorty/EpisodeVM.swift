//
//  LocationVM.swift
//  RickAndMorty
//
//  Created by Yery Castro on 31/3/24.
//

import Foundation


final class EpisodeVM: ObservableObject {
    let network: DataInteractor
    
    @Published var episodes: [Episodes] = []
    @Published var currentPage = 1
    @Published var currentCount = 1
    @Published var search: String = ""
    @Published var info: Info?
    @Published var nextPageURL: URL? = URL(string: "https://rickandmortyapi.com/api/episode")
    
    
    init(network: DataInteractor = Network()) {
        self.network = network
        Task { await getEpisodes2() }
    }
    
    func getEpisodes2() async {
        do {
            let epis = try await network.getEpisode(page: currentPage)
            await MainActor.run {
                episodes += epis
            }
        } catch {
            await MainActor.run {
                print(error.localizedDescription)
            }
        }
    }
    func ultimoItem(episode: Episodes) -> Bool {
        episodes.last?.id == episode.id
    }
    
    func siguientePagina(episode: Episodes) {
        if ultimoItem(episode: episode) {
            currentPage += 1
            Task {
                search.isEmpty ? await getEpisodes2() : await buscarEpisodes()
            }
        }
    }
    func buscarEpisodes() async {
        guard !search.isEmpty else {
            await MainActor.run {
                episodes.removeAll()
            }
            currentPage = 1
            await getEpisodes2()
            return
        }
        
        do {
            let episode = try await network.getEpisode(page: currentPage)
            await MainActor.run {
                if currentPage == 1 {
                    episodes.removeAll()
                }
                episodes += episode
            }
        } catch {
            print(error)
        }
    }
    
    func fetchEpisodes() async {
        // Define la URL de la API
        guard let url = URL(string: "https://rickandmortyapi.com/api/episode") else { return }
        
        do {
            // Realiza la solicitud a la API
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decodifica la respuesta JSON a tu modelo de datos Swift
            let decodedResponse = try JSONDecoder().decode(DTOEpisode.self, from: data)
            
            // Actualiza tus datos publicados con la respuesta
            DispatchQueue.main.async {
                self.episodes = decodedResponse.results
            }
        } catch {
            // Maneja cualquier error que ocurra durante la solicitud o la decodificación
            print("Error al cargar los personajes: \(error)")
        }
    }
    func loadMoreEpisodesIfNeeded(currentLocation episode: Episodes?) async {
        guard let episode = episode, let lastEpisode = episodes.last, episode.id == lastEpisode.id, nextPageURL != nil else { return }
        await loadMoreEpisodes()
    }
    
    func loadMoreEpisodes() async {
        guard let nextPage = nextPageURL else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: nextPage)
            let decodedResponse = try JSONDecoder().decode(DTOEpisode.self, from: data)
            await MainActor.run {
                self.episodes.append(contentsOf: decodedResponse.results)
                if let next = decodedResponse.info.next {
                    self.nextPageURL = URL(string: next)
                } else {
                    self.nextPageURL = nil
                }
            }
        } catch {
            print("Error loading more episodes: \(error)")
        }
    }


}
