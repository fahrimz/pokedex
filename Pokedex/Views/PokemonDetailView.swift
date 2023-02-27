//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 24/02/23.
//

import SwiftUI

struct Header: View {
    let pokemon: Pokemon
    let dismiss: DismissAction
    
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

struct PokemonDetailView: View {
    @EnvironmentObject var vm: ViewModel
    @Environment(\.dismiss) private var dismiss

    let pokemon: Pokemon
    
    let artwork = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork"
    let defaultSprite = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon"
    let dimensions: CGFloat = 230
    let cornerRadius: CGFloat = 20

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Color(pokemon.types[0].type.name.rawValue).ignoresSafeArea()
                
                Image("pokeball_white")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .opacity(0.2)
                    .offset(x: 200, y: -120)
                
                VStack {
                    Header(pokemon: pokemon, dismiss: dismiss)
                    
                    AsyncImage(url: URL(string: "\(artwork)/\(vm.getPokemonIndex(pokemon: pokemon)).png")) { image in
                        if let image = image {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: dimensions, height: dimensions)
                        }
                    } placeholder: {
                        ProgressView()
                            .frame(width: dimensions, height: dimensions)
                    }
                    .zIndex(1)
                    
                    VStack {
//                        Text("Pokedex Entry: \(pokemon.id)").padding(.top, 50)
//                        Text("Weight: \(vm.formatHW(value: vm.pokemonDetails?.weight ?? 0)) kg (\(vm.kgToLbs(kg: vm.pokemonDetails?.weight ?? 0)) lbs.)")
//                        Text("Height: \(vm.formatHW(value: vm.pokemonDetails?.height ?? 0)) m (\(vm.mToInch(m: vm.pokemonDetails?.height ?? 0)))")
                        
                        Text("About").padding(.top, 50).padding(.bottom, 20)
                        
                        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.").padding(.horizontal, 36)

                        
                        Spacer()
                    }
                    .frame(width: geo.size.width)
                    .background(.white)
                    .padding(.bottom, cornerRadius)
                    .cornerRadius(cornerRadius)
                    .padding(.bottom, -cornerRadius - 50)
                    .offset(y: -50)

                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear { vm.getDetails(pokemon: pokemon) }
        .navigationBarHidden(true)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: Pokemon.samplePokemon).environmentObject(ViewModel())
    }
}
