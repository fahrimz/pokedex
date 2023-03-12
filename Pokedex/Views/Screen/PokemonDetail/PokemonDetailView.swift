//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 24/02/23.
//

import SwiftUI
import SlidingTabView

struct PokemonDetailView: View {
    @EnvironmentObject var vm: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var tabIndex = 0
    
    let pokemon: Pokemon

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
                    Header(pokemon: pokemon)
                    
                    SpriteImage(pokeId: vm.getPokemonIndex(pokemon: pokemon), size: dimensions).zIndex(1)
                    
                    VStack {
                        SlidingTabView(
                            selection: $tabIndex,
                            tabs: ["About", "Base Stats", "Evolution", "Moves"],
                            font: .system(size: 14),
                            //                            animation: .easeInOut,
                            activeAccentColor: .black,
                            selectionBarColor: Color(pokemon.types[0].type.name.rawValue),
                            selectionBarHeight: 2
                        ).padding(.top, 50).padding(.horizontal, 20)
                        
                        switch tabIndex {
                        case 0:
                            AboutTab(detail: vm.pokemonDetails, speciesData: vm.speciesData)
                        case 1:
                            StatTab()
                        case 2:
                            EvolutionTab()
                        case 3:
                            MoveTab()
                        default:
                            AboutTab(detail: vm.pokemonDetails, speciesData: vm.speciesData)
                        }
                        
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
        .environmentObject(vm)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: Pokemon.samplePokemon).environmentObject(ViewModel())
    }
}
