//
//  FavoritesView.swift
//  PokemonAPI-APP
//
//  Created by VOLKMAR, RANDALL S. on 4/28/25.
//

import SwiftUI

struct FavoritesView: View {
    
    @Binding var favorites: [Pokemon]
    
    var body: some View {
        NavigationView {
            List(favorites) { pokemon in
                NavigationLink(destination: DetailView(pokemon: pokemon, favorites: $favorites)) {
                    Text(pokemon.name.capitalized)
                }
            }
            .navigationTitle("Favorites")
        }
    }
    
}
