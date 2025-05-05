//
//  Pokemon.swift
//  PokemonAPI-APP
//
//  Created by VOLKMAR, RANDALL S. on 4/28/25.
//

import Foundation
import SpriteKit

struct Pokemon: Codable, Identifiable {
    let id = UUID()
    let name: String
    let url: String
//    let height: Int
//    let width: Int
    
    var spriteURL: String?
    
    enum CodingKeys: String, CodingKey {
        case name, url
    }
}

struct PokemonResponse: Codable {
    let results: [Pokemon]
}

struct PokemonDetail: Codable {
    struct Sprites: Codable {
        let front_default: String?
    }
    let sprites: Sprites
}
