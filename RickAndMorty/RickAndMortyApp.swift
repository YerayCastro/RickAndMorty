//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Yery Castro on 28/3/24.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    @StateObject var vm = CharacterVM()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(vm)
                
        }
    }
}
