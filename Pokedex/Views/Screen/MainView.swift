//
//  MainView.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 12/03/23.
//

import SwiftUI

struct MainView: View {
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
                                }.foregroundColor(.white)
                            }
                        }
                        
                        .animation(.easeIn(duration: 0.3), value: vm.filterPokemon.count)
                        .navigationTitle("Pokedex")
                        .toolbar {
                            NavigationLink(destination: FavView(pokemons: [])) {
                                Image(systemName: "star")
                            }.foregroundColor(.black)
                        }
                    }
                    .searchable(
                        text: $vm.searchText,
                        placement: .navigationBarDrawer(displayMode: .always)
                    )
                    .padding(.top, 16)
                    
                }
            }
            .tint(.black)
        }.environmentObject(vm)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}
