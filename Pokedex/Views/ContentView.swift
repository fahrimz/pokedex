//
//  ContentView.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 24/02/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    
    private var cols: Array<GridItem> { Array(repeating: GridItem(spacing: 0), count: 2) }
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                ZStack {
                    Image("pokeball_gray")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .position(x: geo.size.width - 90, y: 25)
                        .rotationEffect(Angle(degrees: 5))
                        .ignoresSafeArea()
                    
                    ScrollView {
                        LazyVGrid(columns: cols) {
                            ForEach(vm.filterPokemon) { pokemon in
                                NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                    PokemonView(pokemon: pokemon)
                                }.foregroundColor(.white).navigationBarBackButtonHidden()
                            }
                        }
                        
                        .animation(.easeIn(duration: 0.3), value: vm.filterPokemon.count)
                        .navigationTitle("Pokedex")
                    }
                    .searchable(
                        text: $vm.searchText,
                        placement: .navigationBarDrawer(displayMode: .always)
                    )
                    .padding(.top, 16)
                    
                }
            }
        }.environmentObject(vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
