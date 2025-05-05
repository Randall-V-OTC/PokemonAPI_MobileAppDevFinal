//
//  FavoritesView.swift
//  PokemonAPI-APP
//
//  Created by VOLKMAR, RANDALL S. on 4/28/25.
//

import SwiftUI

struct FavoritesView: View {
    @State private var favorites: [Pokemon] = []
    
    var body: some View {
        NavigationView {
            List(favorites) { pokemon in
                Text(pokemon.name.capitalized)
            }
            .navigationTitle("Favorites")
        }
    }
    
}
