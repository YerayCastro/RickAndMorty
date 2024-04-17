//
//  MainView.swift
//  RickAndMorty
//
//  Created by Yery Castro on 1/4/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var vm: CharacterVM
    var body: some View {
        TabView {
            CharactersView()
                .tabItem { Label("Characters", systemImage: "person") }
            LocationsView(vm2: .preview, location: .preview)
                .tabItem { Label("Locations", systemImage: "location") }
            EpisodesView(vm3: .test2)
                .tabItem { Label("Episodes", systemImage: "list.bullet") }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(CharacterVM.test)
        
}
