//
//  FetchCountriesService.swift
//  Lecture-21-Homework
//
//  Created by Barbare Tepnadze on 25.04.24.
//

import Foundation

class NetworkService {
    static let networkManager = NetworkService()
    
    private init() {}
    
    func fetchCountries(completion: @escaping ([Country]?, NetworkError?) -> Void) {
        let urlString = "https://restcountries.com/v3.1/all"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil, NetworkError.invalidUrl)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, NetworkError.wrongResponse)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, NetworkError.wrongResponse)
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(nil, NetworkError.wrongStatusCode(code: httpResponse.statusCode))
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError.emptyData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let countries = try decoder.decode([Country].self, from: data)
                
                DispatchQueue.main.async {
                    completion(countries, nil)
                }
            } catch {
                print("Decoding error: \(error)")
                completion(nil, NetworkError.decodeError)
            }
        }.resume()
    }
}
