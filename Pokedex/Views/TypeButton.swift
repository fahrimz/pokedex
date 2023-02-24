//
//  TypeButton.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 24/02/23.
//

import SwiftUI

struct TypeButton: View {
    let pokeType: EPokeType?
    var body: some View {
        Text("**\(pokeType?.rawValue.capitalized ?? "unknown")**")
            .font(.system(size: 14))
            .padding(EdgeInsets(top: 6, leading: 14, bottom: 6, trailing: 14))
            .foregroundColor(.white)
            .background(Color(pokeType?.rawValue ?? EPokeType.unknown.rawValue))
            .clipShape(Capsule())
    }
}

struct TypeButton_Previews: PreviewProvider {
    static var previews: some View {
        TypeButton(pokeType: EPokeType.grass)
    }
}
