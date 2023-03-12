//
//  Evolution.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 27/02/23.
//

import SwiftUI

struct EvolutionTab: View {
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            if vm.haveEvolution() {
                HStack {
                    if vm.evoChain != nil {
                        EvoItem(id: Helper.getIdFromUrl(url: vm.evoChain!.chain.species.url), name: vm.evoChain!.chain.species.name)
                        
                        if ((vm.evoChain?.chain.evolves_to.count ?? 0) > 0) {
                            Image(systemName: "arrow.right").font(.system(size: 14))
                            
                            VStack {
                                ForEach(vm.evoChain?.chain.evolves_to ?? [], id: \.species.name) { lvl2 in
                                    HStack {
                                        // second level
                                        EvoItem(id: Helper.getIdFromUrl(url: lvl2.species.url), name: lvl2.species.name)
                                        
                                        if lvl2.evolves_to.count > 0 {
                                            Image(systemName: "arrow.right").font(.system(size: 14))
                                            
                                            // third level
                                            VStack {
                                                ForEach(lvl2.evolves_to, id: \.species.name) { lvl3 in
                                                    EvoItem(id: Helper.getIdFromUrl(url: lvl3.species.url), name: lvl3.species.name)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                Text("\(vm.getCurrentPokeName() ?? "This pokemon") does not evolve.").font(.system(size: 14)).foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            if let id = vm.getCurrentEvoChainId() {
                vm.getEvolutionChain(id: id)
            }
        }
    }
}

struct EvolutionTab_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ViewModel()
        EvolutionTab().environmentObject(vm).onAppear {
            vm.getDetails(pokemon: Pokemon.samplePokemon)
        }
    }
}

struct EvoItem: View {
    let id: Int?
    let name: String?
    let size: CGFloat = 100
    
    var body: some View {
        VStack {
            SpriteImage(pokeId: id ?? 1, size: size, useDefault: true)
            Text(Helper.getFormattedPokeId(id: id ?? 1)).font(.system(size: 14)).foregroundColor(.gray)
            Text(name?.capitalized ?? "?").font(.system(size: 14))
        }
    }
}
