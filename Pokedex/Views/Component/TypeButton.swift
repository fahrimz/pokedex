//
//  TypeButton.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 24/02/23.
//

import SwiftUI

struct TypeButton: View {
    let bg: EPokeType?
    let text: String?
    var adaptive: Bool = false
    
    var body: some View {
        Text("**\(text?.capitalized ?? "Unknown")**")
            .font(.system(size: adaptive ? (UIDevice.isIPad ? 16 : 12) : 12))
            .padding(EdgeInsets(top: 6, leading: 14, bottom: 6, trailing: 14))
            .foregroundStyle(Color.white.shadow(.drop(radius: 2)))
            .background(Color("\(bg?.rawValue ?? EPokeType.unknown.rawValue)2"))
            .clipShape(Capsule()).shadow(color: Color(bg?.rawValue ?? EPokeType.unknown.rawValue), radius: 3)
    }
}

struct TypeButton_Previews: PreviewProvider {
    static var previews: some View {
        let adaptiveColumns = [
            GridItem(.adaptive(minimum: 150))
        ]
        
        ScrollView {
            LazyVGrid(columns: adaptiveColumns, spacing: 30) {
                ForEach(EPokeType.allCases, id: \.rawValue) { res in
                    TypeButton(bg: res, text: res.rawValue)
                }
            }.padding(.top, 50)
        }
    }
}
