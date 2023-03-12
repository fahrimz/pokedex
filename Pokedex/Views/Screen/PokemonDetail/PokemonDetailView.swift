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
    
    @Namespace var ns
    @State var expanded = false
    
    let pokemon: Pokemon
    
    let dimensions: CGFloat = 230
    let cornerRadius: CGFloat = 20
    
    var tabView: some View {
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
    }
    
    var body: some View {
        GeometryReader { geo in
            if !expanded {
                ZStack(alignment: .leading) {
                    Color(pokemon.types[0].type.name.rawValue).ignoresSafeArea()
                    
                    Image("pokeball_white")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .opacity(0.2)
                        .position(x: geo.size.width / 1.3, y: geo.size.height / 2.7)
                    
                    VStack {
                        Header(pokemon: pokemon)
                        
                        SpriteImage(pokeId: vm.getPokemonIndex(pokemon: pokemon), size: dimensions)
                            .zIndex(1)
                        
                        tabView
                            .matchedGeometryEffect(id: "tabView", in: ns)
                        
                        Spacer()
                    }
                }
            } else {
                tabView
                    .matchedGeometryEffect(id: "tabView", in: ns)
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
