//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Yery Castro on 28/3/24.
//
//
import SwiftUI

struct CharactersView: View {
    @EnvironmentObject var vm: CharacterVM
    let item = GridItem(.adaptive(minimum: 150))
    @State private var selectedCharacter: Character?
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [item]) {
                    ForEach(vm.characters, id: \.self) { character in
                        CharacterCardView(character: character)
                            .onTapGesture {
                                self.selectedCharacter = character
                            }
                            .sheet(item: $selectedCharacter) { selectedCharacter in
                                CharacterProfileView(character: selectedCharacter)
                            }
                            .onAppear {
                                Task {
                                    await vm.loadMoreCharacters()
                                }
                            }
                    }
                }
            }
//            .searchable(text: $vm.search, placement: .toolbar, prompt: "Busca un character")
//            .onChange(of: vm.search) { oldValue,newValue in
//                    Task {
//                        await vm.buscarCharacters()
//                    }
//                }
            .navigationTitle("Characters")
        }
    }
}


#Preview {
    NavigationStack{
        CharactersView()
            .environmentObject(CharacterVM.test)
    }
}

