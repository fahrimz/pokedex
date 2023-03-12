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
        VStack {
            if vm.havePreviousSpecies() {
                HStack {
                    EvoItem(id: vm.getPreviousSpeciesIndex(), name: vm.getPreviousSpeciesName())
                    Image(systemName: "arrow.right").padding()
                    EvoItem(id: vm.getCurrentPokeId(), name: vm.getCurrentPokeName())
                }
            } else {
                Text("This pokemon does not have previous evolution.").font(.system(size: 14)).foregroundColor(.gray)
            }
        }.frame(maxHeight: .infinity)
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
            SpriteImage(pokeId: id ?? 1, size: size)
            Text(Helper.getFormattedPokeId(id: id ?? 1)).font(.system(size: 14)).foregroundColor(.gray)
            Text(name ?? "?").font(.system(size: 14))
        }
    }
}
