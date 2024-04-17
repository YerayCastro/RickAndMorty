//
//  EpisodesCellView.swift
//  RickAndMorty
//
//  Created by Yery Castro on 2/4/24.
//

import SwiftUI

struct EpisodesCellView: View {
    @ObservedObject var vm3: EpisodeVM
    let title: String
    let label: String
    
    var body: some View {
        Text(title)
        Text(label)
    }
}

#Preview {
    EpisodesCellView(vm3: .test2, title: "ID", label: "1")
}
