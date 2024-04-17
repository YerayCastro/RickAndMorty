//
//  CharacterProfileCardView.swift
//  RickAndMorty
//
//  Created by Yery Castro on 29/3/24.
//

import SwiftUI

struct CharacterProfileCellView: View {
    @EnvironmentObject var vm: CharacterVM
    let character: Character
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
    CharacterProfileCellView(character: .test, title: "Nombre", label: "Rick Suarez")
        .environmentObject(CharacterVM())
}

