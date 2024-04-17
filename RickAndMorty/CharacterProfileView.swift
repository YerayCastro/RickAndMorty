//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Yery Castro on 29/3/24.
//

import SwiftUI

struct CharacterProfileView: View {
    @EnvironmentObject var vm: CharacterVM
    let character: Character
    
    var body: some View {
        let episodesString = character.episode
            .compactMap { $0.split(separator: "/").last }
            .joined(separator: ", ")
        
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.gray.opacity(0.3))
            .padding()
            .overlay(alignment: .topLeading) {
                ScrollView {
                    ZStack {
                        VStack(alignment: .leading) {
                            AsyncImage(url: character.image) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay {
                                        Text(character.name)
                                            .font(.title)
                                            .bold()
                                            .padding(.top,290)
                                    }
                                
                            } placeholder: {
                                Image(systemName: "person")
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding()
                                    .overlay {
                                        Text(character.name)
                                            .font(.title)
                                            .bold()
                                            .padding(.top,250)
                                    }
                            }
                            
                            VStack(alignment: .leading) {
                                CharacterProfileCellView(character: character, title: "ID", label: "\(character.id)")
                                CharacterProfileCellView(character: character, title: "Specie", label: character.species)
                                CharacterProfileCellView(character: character, title: "Gender", label: character.gender.rawValue)
                                CharacterProfileCellView(character: character, title: "Status", label: character.status.rawValue)
                                CharacterProfileCellView(character: character, title: "Type", label: character.type)
                                CharacterProfileCellView(character: character, title: "Origin", label: "\(character.origin.name)")
                                CharacterProfileCellView(character: character, title: "Location", label: "\(character.location.name)")
                                CharacterProfileCellView(character: character, title: "Episode", label: episodesString)
                                CharacterProfileCellView(character: character, title: "Created", label: "\(character.created)")
                            }
                            .padding()
                            
                        }
                        
                        .padding()
                    }
                }
                
                
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity)
        
    }
    
    
}


#Preview {
    NavigationStack{
        CharacterProfileView(character: .test)
            .environmentObject(CharacterVM.test)
    }
}
