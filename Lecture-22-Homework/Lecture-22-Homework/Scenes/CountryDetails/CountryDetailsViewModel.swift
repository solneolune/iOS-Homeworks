//
//  CountryDetailsViewModel.swift
//  Lecture-22-Homework
//
//  Created by Barbare Tepnadze on 26.04.24.
//

import Foundation

final class CountryDetailsViewModel {
    private let country: Country
    
    // MARK: - Init
    init(country: Country) {
        self.country = country
    }
    
    // MARK: - Properties (დიქშენარი კი იყო აქ სვეცკი, მაგრამ ვიუქონთროლერში იყო ხიხო)
    
    var countryName: String {
        return country.name.common
    }
    
    var flagImageURL: String {
        return country.flags.png
    }
    
    var flagAltText: String {
        return country.flags.alt ?? "🤷🏻‍♀️"
    }
    
    var nativeName: String {
        return country.name.nativeName?["kat"]?.official ?? "🤷🏻‍♀️"
    }
    
    var spelling: String {
        return country.altSpellings.first ?? "🤷🏻‍♀️"
    }
    
    var capitals: String {
        return country.capital?.joined(separator: ", ") ?? "🤷🏻‍♀️"
    }
    
    var currencies: String {
        return country.currencies?.map { "\($0.key): \($0.value.name), \($0.value.symbol ?? "🤷🏻‍♀️")" }.joined(separator: ", ") ?? "🤷🏻‍♀️"
    }
    
    var region: String {
        return country.region
    }
    
    var neighbors: String {
        return country.borders?.joined(separator: ", ") ?? "🤷🏻‍♀️"
    }
    
    var openStreetMapsURL: URL? {
        return URL(string: country.maps.openStreetMaps)
    }
    
    var googleMapsURL: URL? {
        return URL(string: country.maps.googleMaps)
    }
}
