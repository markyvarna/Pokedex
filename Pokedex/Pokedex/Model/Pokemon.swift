//
//  Pokemon.swift
//  Pokedex
//
//  Created by Markus Varner on 9/4/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

struct Pokemon: Decodable {
    
    let abilities: [AbilitiesDictionary]
    let name: String
    let id: Int
    let spritesDictionary: SpriteDictionary
    
    private enum CodingKeys: String, CodingKey {
        case abilities
        case name
        case id
        case spritesDictionary = "sprites"
    }
    
    var abilitiesName: [String] {
        
        return abilities.compactMap({$0.ability.name})
        
    }
    struct AbilitiesDictionary: Decodable {
        
        let ability: Ability
        
        struct Ability: Decodable {
            let name: String
        }
    }
    
}



struct SpriteDictionary: Decodable {
    
    let image: URL
    
    //this enum is for the keys that match the json, Decodable knows about CodingKeys enum so spell it right
    private enum CodingKeys: String, CodingKey {
        case image = "front_default"
    }
}
