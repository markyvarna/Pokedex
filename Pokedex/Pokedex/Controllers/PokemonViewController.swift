//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Markus Varner on 9/4/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UISearchBarDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    @IBOutlet var pokemonImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        setUpUi()
        
    }
    
    //MARK: - UI Setup
    
    func setUpUi() {
        view.addVerticalGradientLayer(topColor: .cyan, bottomColor: .white)
        pokemonImageView.layer.borderColor = UIColor.red.cgColor
        pokemonImageView.layer.borderWidth = 3.5
        pokemonImageView.layer.cornerRadius = 5
        pokemonImageView.layer.shadowOffset = CGSize(width: 10, height: 20)
        pokemonImageView.layer.shadowColor = UIColor.lightGray.cgColor
        pokemonImageView.layer.shadowRadius = 2
        pokemonImageView.layer.shadowOpacity = 0.8
    }
    
    
    //MARK: - Search Bar Func
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let pokemonText = searchBar.text?.lowercased() else {return}
        PokemonController.shared.fetchPokemon(by: pokemonText) { (pokemon) in
            guard let unwrappedPokemon = pokemon else {return}
            
            DispatchQueue.main.async {
                
                self.nameLabel.text = unwrappedPokemon.name
                self.idLabel.text = "Pokedex ID: \(String(describing: unwrappedPokemon.id))"
                self.abilitiesLabel.text = "Abilities: \(unwrappedPokemon.abilitiesName.joined(separator: ", "))"
            }
            
            PokemonController.shared.fetchImage(pokemon: unwrappedPokemon, completion: { (image) in
                if image != nil {
                    DispatchQueue.main.async {
                        self.pokemonImageView.image = image
                    }
                } else {
                    self.presentAlertController()
                }
            })
        }
        //dismisses keyboard
        searchBar.resignFirstResponder()
    }
    
    //MARK: - Alert Controller
    
    func presentAlertController(){
        
        let alert = UIAlertController(title: "This poky doesnt have an image :(", message: "Awwwe 🤢", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        present(alert, animated: true)
        
    }
    
}


