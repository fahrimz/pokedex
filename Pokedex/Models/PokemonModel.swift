//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 24/02/23.
//

import Foundation

struct PokemonPage: Codable {
    let count: Int
    let next: String
    let results: [Pokemon]
}

// MARK: - Pokemon

struct Pokemon: Codable, Identifiable, Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let url: String
    let types: [TypeElement]

    static var samplePokemon = Pokemon(id: 1, name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/", types: [TypeElement(slot: 1, type: PokeType(name: EPokeType.grass)), TypeElement(slot: 2, type: PokeType(name: EPokeType.poison))])
}

struct DetailPokemon: Codable {
    let id: Int
    let weight: Int
    let height: Int
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: PokeType
}

// MARK: - TypeType
struct PokeType: Codable {
    let name: EPokeType
}

enum EPokeType: String, Codable {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    case unknown
}

