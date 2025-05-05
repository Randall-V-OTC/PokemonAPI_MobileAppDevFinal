//
//  DetailView.swift
//  PokemonAPI-APP
//
//  Created by VOLKMAR, RANDALL S. on 4/28/25.
//

import SwiftUI

struct DetailView: View {
    var pokemon: Pokemon
    @Binding public var favorites: [Pokemon]
    @State private var showingAlert = false
    @State private var alertType: AlertType = .added
    @State private var spriteURL: String? = nil
    @Environment(\.presentationMode) var presentationMode
    
    enum AlertType {
        case added, removed
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            if let urlString = spriteURL, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                } placeholder: {
                    ProgressView()
                }
            }
            
            VStack {
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
            }
            
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
//            Button("Back to Browse") {
//                presentationMode.wrappedValue.dismiss()
//            }
        }
        .padding()
        .onAppear() {
            fetchPokemonDetail()
        }
        .alert(alertType == .added ? "Added!" : "Removed!", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {}
        }
    }
    
    func fetchPokemonDetail() {
        guard let url = URL(string: pokemon.url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error  in
            guard let data = data else { return }
            
            if let detail = try? JSONDecoder().decode(PokemonDetail.self, from: data),
               let imageURL = detail.sprites.front_default {
                DispatchQueue.main.async {
                    self.spriteURL = imageURL
                }
            }
        }.resume()
    }
    

}
