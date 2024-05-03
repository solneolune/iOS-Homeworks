//
//  CatFactsListViewModel.swift
//  Lecture-23-Homework
//
//  Created by Barbare Tepnadze on 03.05.24.
//

import Foundation
import BarbareDoesNetworking

class CatFactsViewModel {
    var catFacts: [CatFact] = []
    var catFactsCount = 0
    var updateUI: (() -> Void)?
    var showError: ((String) -> Void)?
    
    private let networkService = NetworkService()
    
    func fetchCatFacts() {
        guard let url = URL(string: "https://catfact.ninja/facts") else {
            showError?("Invalid URL")
            return
        }
        
        networkService.fetch(url: url, parse: { data in
            try? JSONDecoder().decode(CatFactsResponse.self, from: data)
        }) { (result: Result<CatFactsResponse?, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if let facts = response?.data {
                        self.catFacts = facts
                        self.catFactsCount = self.catFacts.count
                        self.updateUI?()
                    }
                case .failure(let error):
                    self.showError?("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
