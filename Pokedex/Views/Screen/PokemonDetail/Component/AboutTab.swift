//
//  AboutTab.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 27/02/23.
//

import SwiftUI

struct AboutTab: View {
    @EnvironmentObject var vm: ViewModel
    let detail: DetailPokemon1?
    
    var baseData: some View {
        Group {
            ItemView(field: "Height", value: "\(vm.formatHW(value: detail?.height ?? 0)) m (\(vm.mToInch(m: detail?.height ?? 0)))")
            ItemView(field: "Weight", value: "\(vm.formatHW(value: detail?.weight ?? 0)) kg (\(vm.kgToLbs(kg: detail?.weight ?? 0)) lbs.)")
            ItemView(field: "Abilities", value: vm.getAbilities())
        }
    }
    
    var trainingData: some View {
        Group {
            Text("Training")
                .padding(.top, 10)
            ItemView(field: "EV Yield", value: vm.getEVYields())
            ItemView(field: "Catch Rate", value: "TODO")
            ItemView(field: "Base Friendship", value: "TODO")
            ItemView(field: "Base Exp.", value: String(detail?.base_experience ?? 0))
        }
    }
    
    var breedingData: some View {
        Group {
            Text("Breeding")
                .padding(.top, 10)
            ItemView(field: "Egg Groups", value: "TODO")
            ItemView(field: "Egg Cycle", value: "TODO")
        }
    }
    
    var typeDefenseData: some View {
        Group {
            Text("Type Defense")
                .padding(.top, 10)
            Text("The effectiveness of each type on \(vm.pokemonDetails?.name ?? "?")")
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                baseData
                trainingData
                breedingData
//                typeDefenseData

                Spacer()
            }.padding(.horizontal, 24)
        }
    }
}

struct AboutTab_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ViewModel()
        AboutTab(detail: vm.pokemonDetails).environmentObject(vm)
    }
}
