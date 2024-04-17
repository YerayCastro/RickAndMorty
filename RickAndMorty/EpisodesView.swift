//
//  EpisodesView.swift
//  RickAndMorty
//
//  Created by Yery Castro on 1/4/24.
//

import SwiftUI

struct EpisodesView: View {
    @ObservedObject  var vm3: EpisodeVM
    @State private var selectedEpisode: Episodes?
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm3.episodes, id: \.self) { episode in
                    Text(episode.episode)
                        .font(.title3)
                        .bold()
                        .onTapGesture {
                            self.selectedEpisode = episode
                        }
                        .onAppear {
                            Task {
                                await vm3.loadMoreEpisodes()
                            }
                        }
                        .sheet(item: $selectedEpisode) { selectedEpisode in
                            EpisodesProfileView(vm3: .test2, episode: selectedEpisode)
                        }
                    Text(episode.name)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        
                }
            }
            .navigationTitle("Episodes")
        }
    }
}

#Preview {
    EpisodesView(vm3: .test2)
}



