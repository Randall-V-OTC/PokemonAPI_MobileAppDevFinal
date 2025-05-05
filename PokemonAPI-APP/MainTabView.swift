//
//  MainTabView.swift
//  PokemonAPI-APP
//
//  Created by VOLKMAR, RANDALL S. on 4/28/25.
//

import SwiftUI

struct MainTabView: View {
    
    @State var favorites: [Pokemon] = []
    
    var body: some View {
        TabView {
            BrowseView(favorites: $favorites)
                .tabItem {
                    Label("Browse", systemImage: "list.bullet")
                }
            FavoritesView(favorites: $favorites)
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
        .background(Color.red)
    }
}
