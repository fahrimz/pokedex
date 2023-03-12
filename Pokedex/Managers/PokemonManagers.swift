//
//  PokemonManagers.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 24/02/23.
//

import Foundation

class PokemonManager {
    func getPokemon() -> [Pokemon] {
        let data: PokemonPage = Bundle.main.decode(file: "pokemon.json")
        let pokemon: [Pokemon] = data.results
        
        return pokemon
    }
    
    func getDetailedPokemon(id: Int, _ completion: @escaping(DetailPokemon1) -> ()) {
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon/\(id)/", model: DetailPokemon1.self) { data in
            completion(data)
        } failure: { error in
            print(error)
        }
    }
    
    func getPokemonSpeciesData(id: Int, _ completion: @escaping(DetailPokemon2) -> ()) {
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon-species/\(id)", model: DetailPokemon2.self) { data in
            completion(data)
        } failure: { error in
            print(error)
        }
    }
}
