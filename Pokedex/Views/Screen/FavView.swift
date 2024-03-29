//
//  FavView.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 13/03/23.
//

import SwiftUI

struct FavView: View {
    @Environment(\.dismiss) private var dismiss
    @State var pokemons: [Pokemon] = []
    
    let cols = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var cards: some View {
        ForEach(pokemons, id: \.id){ mon in
            FavCard(pokemon: mon, onToggleFav: {
                pokemons = FavHelper.getFavPokemon()
            })
            .padding(.bottom)
            .animation(.linear(duration: 0.3), value: pokemons)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.backward")
                    .font(.system(size: 24))
                    .onTapGesture { dismiss() }
                
                Text("Favorite")
                    .font(.system(size: 24))
                    .padding(.leading)
                
                Spacer()
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 36)
            .padding([.top, .horizontal], UIDevice.isIPad ? 50 : 0)
            
            if pokemons.count > 0 {
                ScrollView {
                    if UIDevice.isIPad {
                        LazyVGrid(columns: cols) {
                            cards
                        }
                        .padding(.horizontal, 50)
                        .padding(.top, 20)
                    } else {
                        VStack {
                            cards
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
        .onAppear {
            pokemons = FavHelper.getFavPokemon()
        }
    }
}

struct FavView_Previews: PreviewProvider {
    static var previews: some View {
        FavView()
    }
}

struct FavCard: View {
    let pokemon: Pokemon
    let onToggleFav: () -> Void
    
    var body: some View {
        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
            HStack {
                VStack(alignment: .leading) {
                    Group {
                        Text(TextHelper.getFormattedPokeId(id: pokemon.id))
                            .fontWeight(.bold)
                        Text(pokemon.name.capitalized)
                            .font(.system(size: 24, weight: .bold))
                    }
                    
                    Spacer()
                    
                    HStack {
                        TypeButton(bg: EPokeType(rawValue: pokemon.types[0].type.name.rawValue), text: pokemon.types[0].type.name.rawValue, adaptive: true)
                        
                        if pokemon.types.count > 1 {
                            TypeButton(bg: EPokeType(rawValue: pokemon.types[0].type.name.rawValue), text: pokemon.types[1].type.name.rawValue, adaptive: true)
                        } else {
                            Spacer()
                        }
                    }.padding(.top)
                }
                
                Spacer()
                
                ZStack {
                    SpriteImage(pokeId: pokemon.id, size: 150)
                        .offset(x: 20, y: 20)
                        .background(
                            Image("pokeball_white")
                                .resizable()
                                .frame(width: 250, height: 250)
                                .offset(x: 45)
                                .rotationEffect(Angle(degrees: 15))
                                .opacity(0.3)
                        )
                    
                    GeometryReader { geo in
                        Image(systemName: "star.fill").font(.system(size: UIDevice.isIPad ? 24 : 20))
                            .position(x: geo.size.width - (UIDevice.isIPad ? 15 : 10), y: UIDevice.isIPad ? 10 : 5)
                            .highPriorityGesture(TapGesture().onEnded {
                                FavHelper.toggleFavPokemon(pokemon: pokemon)
                                onToggleFav()
                            })
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
