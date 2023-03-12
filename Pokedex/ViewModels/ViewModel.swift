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
    @Published var pokemonDetails: DetailPokemon1?
    @Published var speciesData: DetailPokemon2?
    @Published var evoChain: EvolutionChain?
    @Published var searchText = ""
    
    var filterPokemon: [Pokemon] {
        return searchText == "" ? pokemonList : pokemonList.filter {
            $0.name.contains(searchText.lowercased())
        }
    }
    
    init() {
        self.pokemonList = pokemonManager.getPokemon()

        // evolution tab preview only
//        self.evoChain = EvolutionChain(
//            chain: Chain(evolves_to: [
//                Chain(evolves_to: [
//                    Chain(evolves_to: [], species: Species(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon-species/3/"))
//                ], species: Species(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon-species/2/"))
//            ], species: Species(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon-species/1/")),
//            id: 1
//        )
    }
    
    func getPokemonIndex(pokemon: Pokemon) -> Int {
        if let index = self.pokemonList.firstIndex(of: pokemon) {
            return index + 1
        }
        
        return 0
    }
    
    func getDetails(pokemon: Pokemon) {
        let id = getPokemonIndex(pokemon: pokemon)
        self.pokemonDetails = DetailPokemon1(
            id: 2,
            name: "ivysaur",
            weight: 0,
            height: 0,
            types: [
                TypeElement(slot: 1, type: PokeType(name: EPokeType.grass)),
                TypeElement(slot: 2, type: PokeType(name: EPokeType.poison))
            ],
            abilities: [
                Ability(ability: AbilityName(name: "Overgrow")),
                Ability(ability: AbilityName(name: "Chlorophyl"))
            ],
            base_experience: 60,
            stats: [
                Stat(base_stat: 45, effort: 0, stat: StatName(name: "hp")),
                Stat(base_stat: 49, effort: 0, stat: StatName(name: "attack")),
                Stat(base_stat: 49, effort: 0, stat: StatName(name: "defense")),
                Stat(base_stat: 65, effort: 1, stat: StatName(name: "special-attack")),
                Stat(base_stat: 65, effort: 0, stat: StatName(name: "special-defense")),
                Stat(base_stat: 45, effort: 0, stat: StatName(name: "speed")),
            ],
            moves: [
                Move(move: MoveName(name: "vine-whip")),
                Move(move: MoveName(name: "headbutt")),
            ]
        )
        
        self.speciesData = DetailPokemon2(
            id: 2,
            base_happiness: 50,
            capture_rate: 45,
            egg_groups: [
                EggGroup(name: "monster"),
                EggGroup(name: "plant")
            ],
            hatch_counter: 20,
            growth_rate: GrowthRate(name: "medium-slow"),
            evolves_from_species: EvolveFrom(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon-species/1/"),
            evolution_chain: EvolutionUrl(url: "https://pokeapi.co/api/v2/evolution-chain/1/")
        )
        
        pokemonManager.getDetailedPokemon(id: id) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
        }
        
        pokemonManager.getPokemonSpeciesData(id: id) { data in
            DispatchQueue.main.async {
                self.speciesData = data
            }
        }
    }
    
    func getEvolutionChain(id: Int) {
        pokemonManager.getEvolution(id: id) { data in
            DispatchQueue.main.async {
                self.evoChain = data
            }
        }
    }
    
    func getMoves() -> [String] {
        let moves = self.pokemonDetails?.moves ?? []
        return moves.map { $0.move.name.capitalized.replacingOccurrences(of: "-", with: " ") }
    }
    
    func getEVYields() -> String {
        let stats = self.pokemonDetails?.stats.filter({ $0.effort > 0 }) ?? []
        let yielded = stats.map {
            let text = $0.stat.name.replacingOccurrences(of: "special-attack", with: "special attack").replacingOccurrences(of: "special-defense", with: "special defense").capitalized
            return "\($0.effort) \(text)"
        }
        
        return yielded.joined(separator: ", ")
    }
    
    func getAbilities() -> String {
        guard let abilities = self.pokemonDetails?.abilities else {
            return "?"
        }

        return abilities.map({ $0.ability.name.replacingOccurrences(of: "-", with: " ").capitalized }).joined(separator: ", ")
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
    
    func getEggGroup() -> String {
        guard let groups = self.speciesData?.egg_groups else {
            return "?"
        }
        
        return groups.map { $0.name.capitalized }.joined(separator: ", ")
    }
    
    func getEggCycle() -> String {
        guard let cycle = self.speciesData?.hatch_counter else {
            return "?"
        }

        let step = cycle * 257 // each cycle consist of 257 step in newest generation game
        
        return "\(cycle) (around \(step) steps)"
    }
    
    func getGrowthRate() -> String {
        guard let rate = self.speciesData?.growth_rate else {
            return "?"
        }
        
        return rate.name.replacingOccurrences(of: "-", with: " ").capitalized
    }
    
    func getPreviousSpeciesName() -> String? {
        if let name = self.speciesData?.evolves_from_species?.name {
            return name.capitalized
        }
        
        return nil
    }
    
    func getPreviousSpeciesIndex() -> Int? {
        return Helper.getIdFromUrl(url: self.speciesData?.evolves_from_species?.url)
    }
    
    func havePreviousSpecies() -> Bool {
        return self.speciesData?.evolves_from_species != nil
    }
    
    func haveEvolution() -> Bool {
        return (self.evoChain?.chain.evolves_to.count ?? 0) > 0
    }
    
    func getCurrentPokeId() -> Int? {
        if let id = self.speciesData?.id {
            return id
        }
        
        return nil
    }
    
    func getCurrentPokeName() -> String? {
        if let name = self.pokemonDetails?.name {
            return name.capitalized
        }
        
        return nil
    }
    
    func getCurrentEvoChainId() -> Int? {
        return Helper.getIdFromUrl(url: self.speciesData?.evolution_chain.url)
    }
}
