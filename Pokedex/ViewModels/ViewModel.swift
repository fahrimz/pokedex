//
//  ViewModel.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 24/02/23.
//

import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    private let pokemonManager = PokemonManager()
    
    @Published var pokemonList = [Pokemon]()
    @Published var pokemonDetails: DetailPokemon?
    @Published var searchText = ""
    
    var filterPokemon: [Pokemon] {
        return searchText == "" ? pokemonList : pokemonList.filter {
            $0.name.contains(searchText.lowercased())
        }
    }
    
    init() {
        self.pokemonList = pokemonManager.getPokemon()
        
    }
    
    func getPokemonIndex(pokemon: Pokemon) -> Int {
        if let index = self.pokemonList.firstIndex(of: pokemon) {
            return index + 1
        }
        
        return 0
    }
    
    func getDetails(pokemon: Pokemon) {
        let id = getPokemonIndex(pokemon: pokemon)
        self.pokemonDetails = DetailPokemon(id: 0, weight: 0, height: 0)
        
        pokemonManager.getDetailedPokemon(id: id) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
        }
    }
    
    func formatHW(value: Int) -> String {
        let dValue = Double(value)
        let string = String(format: "%.1f", dValue / 10)
        
        return string
    }
    
    func kgToLbs(kg: Int) -> String {
        let lbs = Double(kg) * 2.2046
        let string = String(format: "%.1f", lbs / 10)

        return string
    }
    
    func mToInch(m: Int) -> String {
        let inchTotal = Double(m) * 3.93700787
        let dFeet = floor(inchTotal / 12)
        let feet = Int(dFeet)
        let dInch = (inchTotal - dFeet) * 12
        let inch = Int(ceil(dInch / 100))
        
        return "\(feet)\'\(inch)\""
    }
}
