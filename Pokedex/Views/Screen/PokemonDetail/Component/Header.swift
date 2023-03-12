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
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.backward")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .onTapGesture { dismiss() }
                
                Spacer()
                
                Image(systemName: "heart")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .onTapGesture { dismiss() }
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
                
                Text("#\(String(format: "%03d", pokemon.id))")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
        }.padding(.horizontal, 36)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(pokemon: Pokemon.samplePokemon)
            .background(Color(Pokemon.samplePokemon.types[0].type.name.rawValue))
    }
}
