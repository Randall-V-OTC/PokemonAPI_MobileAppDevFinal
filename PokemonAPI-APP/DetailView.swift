//
//  DetailView.swift
//  PokemonAPI-APP
//
//  Created by VOLKMAR, RANDALL S. on 4/28/25.
//

import SwiftUI

struct DetailView: View {
    var pokemon: Pokemon
    @Binding var favorites: [Pokemon]
    
    @State private var showingAlert = false
    @State private var alertType: AlertType = .added
    
    enum AlertType {
        case added, removed
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(pokemon.name.capitalized)
                .font(.largeTitle)
            
            if !favorites.contains(where: { $0.name == pokemon.name }) {
                Button("Add to Favorites") {
                    favorites.append(pokemon)
                    alertType = .added
                    showingAlert = true
                }
                .background(Color.gray)
            } else {
                Button("Remove from Favorites") {
                    if let index = favorites.firstIndex(where: { $0.name == pokemon.name }) {
                        favorites.remove(at: index)
                        alertType = .removed
                        showingAlert = true
                    }
                }
                .background(Color.yellow)
            }
        }
        .padding()
        .alert(alertType == .added ? "Added!" : "Removed!", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}
