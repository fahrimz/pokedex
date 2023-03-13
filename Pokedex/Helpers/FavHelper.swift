//
//  FavHelper.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 13/03/23.
//

import Foundation

class FavHelper {
    static func getFavPokemon() -> [Pokemon] {
        return UserDefaults.standard.pokemons
    }
    
    static func setFavPokemonArr(pokemons: [Pokemon]) {
        UserDefaults.standard.pokemons = pokemons
    }
    
    static func isPokemonAFav(id: Int) -> Bool {
        let mons = getFavPokemon()
        return mons.filter { $0.id == id }.count > 0
    }
    
    private static func addFavPokemon(pokemon: Pokemon) {
        var mons = getFavPokemon()
        
        if !isPokemonAFav(id: pokemon.id) {
            mons.append(pokemon)
            setFavPokemonArr(pokemons: mons)
        }
    }
    
    private static func removeFavPokemon(id: Int) {
        var mons = getFavPokemon()
        if let index = mons.firstIndex(where: { $0.id == id }) {
            mons.remove(at: index)
            setFavPokemonArr(pokemons: mons)
        }
    }
    
    static func toggleFavPokemon(pokemon: Pokemon) {
        if isPokemonAFav(id: pokemon.id) {
            removeFavPokemon(id: pokemon.id)
        } else {
            addFavPokemon(pokemon: pokemon)
        }
    }
}
