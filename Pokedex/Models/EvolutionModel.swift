//
//  EvolutionModel.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 12/03/23.
//

import Foundation

// MARK: - EvolutionChain
struct EvolutionChain: Codable {
    let chain: Chain
    let id: Int
//    let babyTriggerItem: NSNull
}

// MARK: - Chain
struct Chain: Codable {
    let evolves_to: [Chain]
    let species: Species
//    let isBaby: Bool
//    let evolutionDetails: [EvolutionDetail]
}

// MARK: - EvolutionDetail
//struct EvolutionDetail: Codable {
//    let gender, heldItem, item, knownMove: NSNull
//    let knownMoveType, location, minAffection, minBeauty: NSNull
//    let minHappiness: NSNull
//    let minLevel: Int
//    let needsOverworldRain: Bool
//    let partySpecies, partyType, relativePhysicalStats: NSNull
//    let timeOfDay: String
//    let tradeSpecies: NSNull
//    let trigger: Species
//    let turnUpsideDown: Bool
//}

// MARK: - Species
struct Species: Codable {
    let name: String
    let url: String
}
