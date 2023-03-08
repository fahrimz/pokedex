//
//  ItemView.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 07/03/23.
//

import SwiftUI


struct Item: Identifiable {
  var id = UUID()
  var field: String
  var value: String
}

struct ItemView: View {
    let field: String
    let value: String
    
    var body: some View {
        HStack {
            Text(field)
                .frame(width: 100, alignment: .leading)
                .foregroundColor(.gray)
                .font(.system(size: 14))
            
            Text(value)
                .font(.system(size: 14))
            
            Spacer()
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(field: "Egg Groups", value: "Monster, Grass")
    }
}
