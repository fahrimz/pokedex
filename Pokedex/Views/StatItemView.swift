//
//  StatItemView.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 07/03/23.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

struct StatItemView: View {
    let field: String
    let value: Int
    
    @State var barWidth: CGFloat = 0
    
    var body: some View {
        HStack {
            Text(field)
                .frame(width: 80, alignment: .leading)
                .foregroundColor(.gray)
                .font(.system(size: 14))
            
            Text(String(value))
                .font(.system(size: 14))
                .frame(width: 40, alignment: .leading)
            
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(.gray)
                    .frame(height: 3)
                    .opacity(0.3)
                    .readSize { newSize in
                        let percentage = CGFloat(value) / 255 * 100
                        barWidth = percentage / 100 * newSize.width
                    }
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color( value <= 60 ? "fire" : value <= 85 ? "electric" : "grass"  ))
                    .frame(width: barWidth, height: 2)
            }
            
            Spacer()
        }
    }
}

struct StatItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StatItemView(field: "Attack", value: 9)
            StatItemView(field: "Defense", value: 140)
            StatItemView(field: "Special Attack", value: 65)
            StatItemView(field: "Special Defense", value: 200)
            StatItemView(field: "Speed", value: 30)
        }
    }
}
