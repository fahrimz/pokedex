//
//  MoveView.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 27/02/23.
//

import SwiftUI

struct MoveTab: View {
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        List {
            ForEach(vm.getMoves(), id: \.self) {
                Text($0).font(.system(size: 14))
            }
        }.listStyle(.plain)
    }
}

struct MoveView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ViewModel()
        MoveTab().environmentObject(vm)
    }
}
