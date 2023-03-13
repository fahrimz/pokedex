//
//  TextHelper.swift
//  Pokedex
//
//  Created by Fahri Zulkarnaen on 13/03/23.
//

import Foundation

class TextHelper {
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
