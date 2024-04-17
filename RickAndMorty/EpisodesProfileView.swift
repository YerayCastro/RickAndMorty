//
//  EpisodesView.swift
//  RickAndMorty
//
//  Created by Yery Castro on 1/4/24.
//

import SwiftUI

struct EpisodesProfileView: View {
    @ObservedObject var vm3: EpisodeVM
    let episode: Episodes
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.gray.opacity(0.3))
            .padding()
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading) {
                    EpisodeProfileCellView(title: "ID", label: "\(episode.id)")
                    EpisodeProfileCellView(title: "Episode", label: episode.episode)
                    EpisodeProfileCellView(title: "Name", label: episode.name)
                    EpisodeProfileCellView(title: "Air date", label: episode.air_date)
                    EpisodeProfileCellView(title: "Create", label: episode.created)
                    EpisodeProfileCellView(title: "Url", label: "\(episode.url)")
                    
                }
                .padding(25)
                
            }
            .padding()
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        EpisodesProfileView(vm3: .test2, episode:  .test2)
            .environmentObject(EpisodeVM.test2)
    }
}

