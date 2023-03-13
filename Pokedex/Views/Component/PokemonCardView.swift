//
//  PokemonView.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 24/02/23.
//

import SwiftUI

struct PokemonView: View {
    @State var opacity: CGFloat = 0.0
    
    @EnvironmentObject var vm: ViewModel
    let pokemon: Pokemon
    let dimensions: Double = 95
    var body: some View {
        ZStack {
            Image("pokeball_white")
                .resizable()
                .frame(width: 100, height: 100)
                .offset(x: 45, y: 30)
                .opacity(0.3)
            
            VStack(alignment: .leading) {
                Text("\(pokemon.name.capitalized)")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)

                HStack {
                    VStack(alignment: .leading) {
                        TypeButton(bg: EPokeType(rawValue: pokemon.types[0].type.name.rawValue), text: pokemon.types[0].type.name.rawValue)

                        if pokemon.types.count > 1 {
                            TypeButton(bg: EPokeType(rawValue: pokemon.types[0].type.name.rawValue), text: pokemon.types[1].type.name.rawValue)
                        }

                        Spacer()
                    }

                    Spacer()
                }
            }

            SpriteImage(pokeId: vm.getPokemonIndex(pokemon: pokemon), size: dimensions).offset(x: 40, y: 30)
        }
        .frame(width: 150, height: 120)
        .padding(15)
        .background(Color(pokemon.types[0].type.name.rawValue))
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeInOut(duration: 1)) {
                opacity = 1
            }
        }
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(pokemon: Pokemon.samplePokemon).environmentObject(ViewModel())
    }
}
