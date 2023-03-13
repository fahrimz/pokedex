//
//  Helpers.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 24/02/23.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) from bundle.")
        }
        
        return loadedData
    }
    
    func fetchData<T: Decodable>(url: String, model: T.Type, completion: @escaping(T) -> (), failure: @escaping(Error) -> ()) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    failure(error)
                }
                
                return
            }
            
            do {
                let serverData = try JSONDecoder().decode(T.self, from: data)
                completion(serverData)
            } catch {
                failure(error)
            }
        }.resume()
    }
}

extension Encodable {
    var prettyJSON: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self),
              let output = String(data: data, encoding: .utf8)
        else { return "Error converting \(self) to JSON string" }
        return output
    }
}

extension UserDefaults {
    var pokemons: [Pokemon] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "pokemons") else { return [] }
            return (try? PropertyListDecoder().decode([Pokemon].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "pokemons")
        }
    }
}

class Helper {
    static func getFormattedPokeId(id: Int) -> String {
        return "#\(String(format: "%03d", id))"
    }
    
    static func getIdFromUrl(url: String?) -> Int? {
        if let id = url?.split(separator: "/").last {
            return Int(id)
        }
        
        return nil
    }
}

class FavHelper {
    static func getFavPokemon() -> [Pokemon] {
        return UserDefaults.standard.pokemons
    }
    
    static func setFavPokemonArr(pokemons: [Pokemon]) {
        UserDefaults.standard.pokemons = pokemons
    }
    
    static func isPokemonAFav(id: Int) -> Bool {
        let mons = getFavPokemon()
        return mons.filter { $0.id == id }.count > 0
    }
    
    private static func addFavPokemon(pokemon: Pokemon) {
        var mons = getFavPokemon()
        
        if !isPokemonAFav(id: pokemon.id) {
            mons.append(pokemon)
            setFavPokemonArr(pokemons: mons)
        }
    }
    
    private static func removeFavPokemon(id: Int) {
        var mons = getFavPokemon()
        if let index = mons.firstIndex(where: { $0.id == id }) {
            mons.remove(at: index)
            setFavPokemonArr(pokemons: mons)
        }
    }
    
    static func toggleFavPokemon(pokemon: Pokemon) {
        if isPokemonAFav(id: pokemon.id) {
            removeFavPokemon(id: pokemon.id)
        } else {
            addFavPokemon(pokemon: pokemon)
        }
    }
}
