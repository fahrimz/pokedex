//
//  SpriteImage.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 27/02/23.
//

import SwiftUI

struct SpriteImage: View {
    let pokeId: Int
    let size: CGFloat
    var useDefault = false
    let artwork = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork"
    let defaultSprite = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-viii/icons"
    
    var body: some View {
        AsyncImage(url: URL(string: "\(useDefault ? defaultSprite : artwork)/\(pokeId).png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
            } else if phase.error != nil {
                Image(systemName: "questionmark.app.dashed")
                    .resizable()
                    .scaledToFit()
                    .padding(.top)
                    .padding(.horizontal)
                    .frame(width: size, height: size)
            } else {
                ProgressView()
                    .frame(width: size, height: size)
            }
        }
    }
}

struct SpriteImage_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .bottom) {
            SpriteImage(pokeId: 1, size: 80)
            SpriteImage(pokeId: 1, size: 80, useDefault: true)
            SpriteImage(pokeId: 900, size: 80, useDefault: true)
            SpriteImage(pokeId: 1020, size: 80)
        }
    }
}
