//
//  CountryModel.swift
//  Lecture-21-Homework
//
//  Created by Barbare Tepnadze on 25.04.24.
//

import Foundation

struct Country: Codable {
    let name: Name
    let flags: Flags
    let altSpellings: [String]
    let capital: [String]?
    let currencies: [String: Currency]?
    let region: String
    let borders: [String]?
    let maps: MapLinks
    
    struct Name: Codable {
        let common: String
        let official: String
        let nativeName: [String: NativeLanguage]?
    }
    
    struct Flags: Codable {
        let png: String
        let svg: String
        let alt: String?
    }
    
    struct NativeLanguage: Codable {
        let official: String
        let common: String
    }
    
    struct Currency: Codable {
        let name: String
        let symbol: String?
    }
    
    struct MapLinks: Codable {
        let googleMaps: String
        let openStreetMaps: String
    }
}
