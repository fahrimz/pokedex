//
//  MainView.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 12/03/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var vm = ViewModel()
    @State var isFilterShown = false
    
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
                    
                    if vm.filterPokemon.count > 0 {
                        ScrollView {
                            LazyVGrid(columns: cols) {
                                ForEach(vm.filterPokemon) { pokemon in
                                    NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                        PokemonView(pokemon: pokemon)
                                    }.foregroundColor(.white)
                                }
                            }
                            .animation(.easeIn(duration: 0.3), value: vm.filterPokemon.count)
                        }
                        .padding(.top, 16)
                    } else {
                        VStack {
                            Text("No Pokemon Available").foregroundColor(.gray)
                            Text("Try searching with different type or keyword").foregroundColor(.gray)
                        }
                    }
                }
                .navigationTitle("Pokedex")
                .searchable(
                    text: $vm.searchText,
                    placement: .navigationBarDrawer(displayMode: .always)
                )
                .toolbar {
                    NavigationLink(destination: FavView()) {
                        Image(systemName: "star")
                    }.foregroundColor(.black)
                    Image(systemName: "slider.horizontal.3")
                        .onTapGesture {
                            isFilterShown.toggle()
                        }
                }
            }
            .tint(.black)
        }
        .sheet(isPresented: $isFilterShown) {
            FilterSheet(selectedType: $vm.pokemonType, onSave: {
                isFilterShown.toggle()
            })
        }
        .environmentObject(vm)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
