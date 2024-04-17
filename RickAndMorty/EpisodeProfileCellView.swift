//
//  EpisodeProfileCellView.swift
//  RickAndMorty
//
//  Created by Yery Castro on 2/4/24.
//

import SwiftUI

struct EpisodeProfileCellView: View {
    var title: String
    var label: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title3)
                .bold()
            Text(label)
                .font(.subheadline)
                .bold()
                .lineLimit(2)
            
        }
    }
}

#Preview {
    EpisodeProfileCellView(title: "Episode", label: "S01E02")
}
