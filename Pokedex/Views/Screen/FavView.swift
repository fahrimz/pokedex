//
//  FavView.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 13/03/23.
//

import SwiftUI

struct FavView: View {
    @Environment(\.dismiss) private var dismiss
    
    let pokemons: [Pokemon]
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.backward")
                    .font(.system(size: 24))
                    .onTapGesture { dismiss() }
                
                Text("Favorite")
                    .font(.system(size: 24))
                
                Spacer()
            }
            .padding(.top, 20)
            .padding(.horizontal, 36)
            
            if pokemons.count > 0 {
                ScrollView {
                    VStack {
                        ForEach(pokemons, id: \.id){ mon in
                            FavCard(pokemon: mon)
                                .padding(.bottom)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            } else {
                Text("There is no favorite pokemon here!")
                    .foregroundColor(.gray)
                    .frame(maxHeight: .infinity)
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

struct FavView_Previews: PreviewProvider {
    static var previews: some View {
        let pokemons: [Pokemon] = [
            Pokemon.samplePokemon,
            Pokemon.samplePokemon,
            Pokemon.samplePokemon,
            Pokemon.samplePokemon,
            Pokemon.samplePokemon,
            Pokemon.samplePokemon,
            Pokemon.samplePokemon
        ]
        
        FavView(pokemons: pokemons)
    }
}

struct FavCard: View {
    let pokemon: Pokemon
    
    var body: some View {
        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(Helper.getFormattedPokeId(id: pokemon.id))
                        .fontWeight(.bold)
                    Text(pokemon.name.capitalized)
                        .font(.system(size: 24, weight: .bold))
                    
                    Spacer()
                    
                    HStack {
                        TypeButton(bg: EPokeType(rawValue: pokemon.types[0].type.name.rawValue), text: pokemon.types[0].type.name.rawValue)
                        
                        if pokemon.types.count > 1 {
                            TypeButton(bg: EPokeType(rawValue: pokemon.types[0].type.name.rawValue), text: pokemon.types[1].type.name.rawValue)
                        }
                    }.padding(.top)
                }
                
                Spacer()
                
                ZStack {
                    SpriteImage(pokeId: pokemon.id, size: 130)
                        .offset(x: 0, y: 15)
                        .background(
                            Image("pokeball_white")
                                .resizable()
                                .frame(width: 250, height: 250)
                                .offset(x: 45)
                                .rotationEffect(Angle(degrees: 15))
                                .opacity(0.3)
                        )
                    
                    GeometryReader { geo in
                        Image(systemName: "star.fill").font(.system(size: 20))
                            .position(x: geo.size.width - 10, y: 5)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(pokemon.types[0].type.name.rawValue))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
