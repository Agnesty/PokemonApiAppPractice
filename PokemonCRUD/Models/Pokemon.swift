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






