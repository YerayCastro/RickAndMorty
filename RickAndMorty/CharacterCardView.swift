//
//  CharacterCardView.swift
//  RickAndMorty
//
//  Created by Yery Castro on 29/3/24.
//

import SwiftUI

struct CharacterCardView: View {
    @EnvironmentObject var vm: CharacterVM
    let character: Character
    
    var body: some View {
        VStack {
            AsyncImage(url: character.image) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
            } placeholder: {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Text(character.name)
                .font(.subheadline)
                .bold()
        }
    }
}

#Preview {
    CharacterCardView(character: .test)
        .environmentObject(CharacterVM())
}
