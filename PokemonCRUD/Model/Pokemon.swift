//
//  Pokemon.swift
//  PokemonCRUD
//
//  Created by Agnes Triselia Yudia on 12/07/23.
//

import Foundation

struct Pokemon: Codable {
//    var count: Int
//    var next: String
//    var previous: String
    var results: [SpecificPokemon]
}

struct SpecificPokemon: Codable {
    var name: String
    var url: String
}

struct DetailPokemon: Codable {
    let id: Int
    let abilities: [Ability]
    let sprites: PokemonSprites
    let height: Int
    let weight: Int
    let types: [TypeElement]
    let species: Species
    let moves: [Move]
}

struct Move: Codable {
    let move: Species
}

struct Ability: Codable {
    let ability: Species
}

struct TypeElement: Codable {
    let type: Species
}

struct Species: Codable {
    let name: String
    let url: String
}

struct PokemonSprites: Codable {
    var frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}







