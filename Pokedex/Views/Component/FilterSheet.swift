//
//  FilterSheet.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 15/03/23.
//

import SwiftUI

struct FilterSheet: View {
    @Binding var selectedType: String
    @State var innerSelectedType: String = ""
    let onSave: () -> Void
    
    let typings = EPokeType.allCases.map { $0.rawValue }
    let cols: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
//    @State var toggles = Array(repeating: false, count: EPokeType.allCases.count)
    
    var body: some View {
        VStack {
            Text("Filter")
                .font(.title)
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .leading)
            Group {
                Text("Pokemon Type")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)

//                LazyVGrid(columns: cols, spacing: 10) {
//                    ForEach(Array(typings.enumerated()), id: \.element) { index, element in
//                        Text(element.capitalized)
//                            .font(.system(size: 12, weight: .bold))
//                            .foregroundColor(toggles[index] ? .white : .black)
//                            .frame(maxWidth: .infinity)
//                            .padding(10)
//                            .background(toggles[index] ? Color(element) : .white)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 4)
//                                    .stroke(toggles[index] ? Color("\(element)2") : .black, lineWidth: 1)
//                            )
//                            .padding(5)
//                            .onTapGesture {
//                                toggles[index].toggle()
//                            }
//                            .scaleEffect(toggles[index] ? 1 : 0.9)
//                            .animation(.easeOut, value: toggles[index])
//                    }
//                }
//
                LazyVGrid(columns: cols) {
                    ForEach(typings, id: \.self) { element in
                        if element != EPokeType.unknown.rawValue {
                            TypeToggle(element: element, selectedType: $innerSelectedType, onTap: {
                                if (innerSelectedType != element) {
                                    innerSelectedType = element
                                } else {
                                    innerSelectedType = "" // unselect the current type
                                }
                            })
                        }
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Button("Save") {
                    selectedType = innerSelectedType
                    onSave()
                }
                .buttonStyle(CustomButtonStyle(bg: innerSelectedType == "" ? EPokeType.unknown.rawValue : innerSelectedType))
            }
        }
        .padding(30)
        .onAppear {
            innerSelectedType = selectedType
        }
    }
}

struct FilterSheet_Previews: PreviewProvider {
    static var noop : () -> Void = {}

    static var previews: some View {
        StatefulPreviewWrapper("") {
            FilterSheet(selectedType: $0, onSave: noop)
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    let bg: String
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
            .background(configuration.isPressed ? Color(bg).opacity(0.5) : Color(bg))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 1.5 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct TypeToggle: View {
    let element: String
    @Binding var selectedType: String
    let onTap: () -> Void

    var body: some View {
        Text(element.capitalized)
            .font(.system(size: UIDevice.isIPad ? 18 : 14, weight: .bold))
            .foregroundColor(selectedType == element ? .white : .black)
            .frame(maxWidth: .infinity)
            .padding(UIDevice.isIPad ? 20 : 10)
            .background(selectedType == element ? Color(element) : .white)
            .border(selectedType == element ? Color("\(element)2") : .black)
//            .overlay(
//                RoundedRectangle(cornerRadius: 4)
//                    .stroke(selectedType == element ? Color("\(element)2") : .black, lineWidth: 1)
//            )
            .onTapGesture {
                onTap()
            }
            .scaleEffect(selectedType == element ? 1 : 0.9)
            .animation(.easeOut(duration: 0.2), value: selectedType)
    }
}
