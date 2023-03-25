//
//  StatTab.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 27/02/23.
//

import SwiftUI

struct StatTab: View {
    @EnvironmentObject var vm: ViewModel
    
    var statData: some View {
        VStack {
            ForEach(vm.pokemonDetails?.stats ?? [], id: \.stat.name) {
                StatItemView(field: $0.stat.name.replacingOccurrences(of: "special-attack", with: "Sp. Atk").replacingOccurrences(of: "special-defense", with: "Sp. Def").capitalized, value: $0.base_stat)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Divider().padding(.vertical)
            
            Text("Total Stat: \(vm.getTotalStat())")
                .font(.system(.headline))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            statData

            Spacer()
        }.padding(.horizontal, 24)
    }
}

struct StatTab_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ViewModel()
        StatTab().environmentObject(vm)
    }
}
