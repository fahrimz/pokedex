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
    let artwork = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork"
    let defaultSprite = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon"
    
    var body: some View {
        AsyncImage(url: URL(string: "\(artwork)/\(pokeId).png")) { image in
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
            }
        } placeholder: {
            ProgressView()
                .frame(width: size, height: size)
        }
    }
}

struct SpriteImage_Previews: PreviewProvider {
    static var previews: some View {
        SpriteImage(pokeId: 1, size: 150)
    }
}
