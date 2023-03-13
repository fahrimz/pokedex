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
    @State var expanded = false
    
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
                    .position(x: geo.size.width / 1.3, y: geo.size.height / 2.7)
                
                VStack {
                    Header(pokemon: pokemon)
                    
                    Spacer()
                }
                
                SpriteImage(pokeId: vm.getPokemonIndex(pokemon: pokemon), size: dimensions)
                    .zIndex(1)
                    .position(x: geo.size.width / 2, y: geo.size.height / 2.6)
                    .scaleEffect(expanded ? 0.1 : 1) // using 0.1 to avoid "ignoring singular matrix..." console warning
                    .opacity(expanded ? 0 : 1)
                    .animation(expanded ? .easeIn.speed(3) : .spring().delay(0.3), value: expanded)
                
                VStack {
                    SlidingTabView(
                        selection: $tabIndex,
                        tabs: ["About", "Base Stats", "Evolution", "Moves"],
                        font: .system(size: 14),
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
                .frame(maxWidth: .infinity)
                .background(.white)
                .padding(.bottom, cornerRadius)
                .cornerRadius(cornerRadius)
                .padding(.bottom, -cornerRadius - 50)
                .offset(y: -50)
                .gesture(DragGesture().onChanged { value in
                    let scrollDown = value.translation.height > 0
                    withAnimation { expanded = scrollDown ? false : true }
                })
                .offset(y: expanded ? 0 : geo.size.height / 1.9)
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
