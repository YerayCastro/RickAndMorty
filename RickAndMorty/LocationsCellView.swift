//
//  LocationsCellView.swift
//  RickAndMorty
//
//  Created by Yery Castro on 1/4/24.
//

import SwiftUI

struct LocationsCellView: View {
    @ObservedObject var vm2: LocationVM
    var title: String
    var label: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title3)
                .bold()
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    LocationsCellView( vm2: .preview, title: "Name", label: "Earth")
        .environmentObject(LocationVM.preview)
}

