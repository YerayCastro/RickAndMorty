//
//  CharacterVM.swift
//  RickAndMorty
//
//  Created by Yery Castro on 28/3/24.
//

import SwiftUI

final class CharacterVM: ObservableObject {
    let network: DataInteractor
    
    @Published var characters: [Character] = []
    @Published var currentPage = 1
    @Published var currentCount = 1
    @Published var search: String = ""
    @Published var info: Info?
    @Published var nextPageURL: URL? = URL(string: "https://rickandmortyapi.com/api/character")
    
    
    init(network: DataInteractor = Network()) {
        self.network = network
        Task { await getCharacter2() }
    }
    
    func getCharacter2() async {
        do {
            let chars = try await network.getCharacter(page: currentPage)
            await MainActor.run {
                characters += chars
            }
        } catch {
            await MainActor.run {
                print(error.localizedDescription)
            }
        }
    }
    func ultimoItem(character: Character) -> Bool {
        characters.last?.id == character.id
    }
    
    func siguientePagina(character: Character) {
        if ultimoItem(character: character) {
            currentPage += 1
            Task {
                search.isEmpty ? await getCharacter2() : await buscarCharacters()
            }
        }
    }
    func buscarCharacters() async {
        guard !search.isEmpty else {
            await MainActor.run {
                characters.removeAll()
            }
            currentPage = 1
            await getCharacter2()
            return
        }
        
        do {
            let character = try await network.getCharacter(page: currentPage)
            await MainActor.run {
                if currentPage == 1 {
                    characters.removeAll()
                }
                characters += character
            }
        } catch {
            print(error)
        }
    }
    
    func fetchCharacters() async {
        // Define la URL de la API
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
        
        do {
            // Realiza la solicitud a la API
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decodifica la respuesta JSON a tu modelo de datos Swift
            let decodedResponse = try JSONDecoder().decode(DTOCharacter.self, from: data)
            
            // Actualiza tus datos publicados con la respuesta
            DispatchQueue.main.async {
                self.characters = decodedResponse.results
            }
        } catch {
            // Maneja cualquier error que ocurra durante la solicitud o la decodificación
            print("Error al cargar los personajes: \(error)")
        }
    }
    func loadMoreCharactersIfNeeded(currentCharacter character: Character?) async {
        guard let character = character, let lastCharacter = characters.last, character.id == lastCharacter.id else { return }
        await loadMoreCharacters()
    }
    
    func loadMoreCharacters() async {
        guard let nextPageURL = nextPageURL else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: nextPageURL)
            let decodedResponse = try JSONDecoder().decode(DTOCharacter.self, from: data)
            DispatchQueue.main.async {
                let newCharacters = decodedResponse.results.filter { newCharacter in
                    !self.characters.contains(where: { $0.id == newCharacter.id })
                }
                self.characters += newCharacters
                self.nextPageURL = URL(string: decodedResponse.info.next ?? "")
            }
        } catch {
            print("Error loading more characters: \(error)")
        }
    }
}
   

    
    




