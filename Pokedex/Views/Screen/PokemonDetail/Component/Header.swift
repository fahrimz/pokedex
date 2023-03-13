//
//  Header.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 27/02/23.
//

import SwiftUI

struct Header: View {
    let pokemon: Pokemon
    @Environment(\.dismiss) private var dismiss
    @State var isFav = false
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.backward")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .onTapGesture { dismiss() }
                
                Spacer()
                
                Image(systemName: isFav ? "star.fill" : "star")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .onTapGesture {
                        FavHelper.toggleFavPokemon(pokemon: pokemon)
                        isFav.toggle()
                    }
                    .animation(.interpolatingSpring(stiffness: 170, damping: 8), value: isFav)
            }.padding(.vertical, 20)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(pokemon.name.capitalized)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                    
                    HStack {
                        TypeButton(bg: EPokeType(rawValue: pokemon.types[0].type.name.rawValue), text: pokemon.types[0].type.name.rawValue)
                        
                        if pokemon.types.count > 1 {
                            TypeButton(bg: EPokeType(rawValue: pokemon.types[0].type.name.rawValue), text: pokemon.types[1].type.name.rawValue)
                        }
                        
                        Spacer()
                    }
                }
                
                Spacer()
                
                Text(Helper.getFormattedPokeId(id: pokemon.id))
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 36)
        .onAppear {
            isFav = FavHelper.isPokemonAFav(id: pokemon.id)
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(pokemon: Pokemon.samplePokemon)
            .background(Color(Pokemon.samplePokemon.types[0].type.name.rawValue))
    }
}
