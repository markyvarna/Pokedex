//
//  PokemonController.swift
//  Pokedex
//
//  Created by Markus Varner on 9/4/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class PokemonController {
    
    //https://pokeapi.co/api/v2/pokemon/pikachu/
    
    //A1
    static let shared = PokemonController()
    
    //A2
    //this makes it so we cant make another instance of PokemonController outside of this class
    //this helps prevent memory leak
    private init() {}
    
    //MARK: - Properties
    
    //B3.) We need base url
    //if the url has just http instead of https Add "Allow Transport Safety Settings to plist
    let baseURL = URL(string: "https://pokeapi.co/api/v2")
    
    
    //B1.)Know what you want to display (complete) to the user
    /*@escaping - this indicates that the func's closure will escape the func and complete later.
    this provides the ability to create 2 paths when you call it*/
    func fetchPokemon(by pokemonName: String, completion: @escaping (Pokemon?) -> Void) {
        
        
        //B4.) Build your url - Components ("/"), Querys [:], and extentsions (".")
        guard let unwrappedBaseUrl = baseURL else {
            fatalError("Bad baseURL")
        }
        //use this if you want to use components..
//        var components = URLComponents(url: unwrappedBaseUrl, resolvingAgainstBaseURL: true)
        
        
        let requestURL = unwrappedBaseUrl.appendingPathComponent("pokemon").appendingPathComponent(pokemonName)
        
        print(requestURL.absoluteString)
        
        //B2.) Call URLSession - so you can work backwards
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            
            //C1) Do try catch
            do {
                //C2.2) this will catch any error and throw it to the catch block
                if let error = error { throw error}
                
                //C3) Handle Data
                guard let data = data else { throw NSError() }
                
                //C4) JSONDecoder
                //C5) Decode & Complete with obj
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(pokemon)
                
            } catch let error {
                
                //C2.1) Handle error
                print("🤬Error fetching pokemon \(error) \(error.localizedDescription)")
                completion(nil); return
                
            }
            
        }.resume()
        
    }
    
    func fetchImage(pokemon: Pokemon, completion: @escaping (UIImage?) -> Void) {
        
        let imageUrl = pokemon.spritesDictionary.image
        
        URLSession.shared.dataTask(with: imageUrl) { (data, _, error) in
            //Do try Catch
            do {
                
                if let error = error { throw error }
                guard let data =  data else { throw NSError() }
                guard let image = UIImage(data: data) else { completion(nil); return }
                print("Are you on the main thread?? 🧐 \(Thread.isMainThread)")
                completion(image)
                
            } catch let error {
                
                print(" Error fetching image \(error) \(error.localizedDescription)")
                
            }
            
        }.resume()
    }
    
}
