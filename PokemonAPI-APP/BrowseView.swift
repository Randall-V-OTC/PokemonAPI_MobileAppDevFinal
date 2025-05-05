//
//  BrowseView.swift
//  PokemonAPI-APP
//
//  Created by VOLKMAR, RANDALL S. on 4/28/25.
//

import SwiftUI

struct BrowseView: View {
    @State private var pokemonList: [Pokemon] = []
    @State private var searchText: String = ""
    @State private var favorites: [Pokemon] = []
    
    var body: some View {
        
        NavigationView {
        
            VStack {
                Text("Randall's Pokémon Finder")
                    .font(.system(size:26))
                
                TextField("Search by Pokémon name or ID", text: $searchText, onCommit: fetchPokemon)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                HStack {
                    
                    Button("Clear") {
                        searchText = ""
                        fetchPokemon()
                    }
                    .frame(width: 195, height: 35)
                    .foregroundColor(Color.black)
                    .background(Color.white)
                    .cornerRadius(5)
                    
                    Button("Submit") {
                        fetchPokemon()
                    }
                    .frame(width: 195, height: 35)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .cornerRadius(5)
                    
                }
                .frame(width: 400)
                
                List(pokemonList) { pokemon in
                    NavigationLink(destination: DetailView(pokemon: pokemon, favorites: $favorites)) {
                        Text(pokemon.name.capitalized)
                    }
                }
                .onAppear(perform: fetchPokemon)
            }
            .background(Color.red)
        }
    }

    func fetchPokemon() {
        let urlStr = "https://pokeapi.co/api/v2/pokemon?limit=151" // 151 og Pokemon
        guard let url = URL(string: urlStr) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse =  try JSONDecoder().decode(PokemonResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        if (searchText.isEmpty) {
                            self.pokemonList = decodedResponse.results
                        } else {
                            self.pokemonList = decodedResponse.results.filter {
                                $0.name.contains(searchText.lowercased())
                            }
                        }
                    }
                } catch {
                    print("Decoding error:\(error)")
                }
            } else if let error = error {
                print("HTTP Request Failed:\(error)")
            }
        }.resume()
    }
}
