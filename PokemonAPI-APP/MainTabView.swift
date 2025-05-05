//
//  MainTabView.swift
//  PokemonAPI-APP
//
//  Created by VOLKMAR, RANDALL S. on 4/28/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "list.bullet")
                }
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
        .background(Color.red)
    }
}
