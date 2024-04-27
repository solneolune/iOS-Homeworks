//
//  CountriesViewModel.swift
//  Lecture-22-Homework
//
//  Created by Barbare Tepnadze on 26.04.24.
//

import Foundation

    // MARK: - Protocol
protocol CountriesViewModelDelegate: AnyObject {
    func countriesFetched(_ countries: [Country])
    func navigateToDetailsVC(selectedCountry: Country)
    func updateTableView()
    func showFirstTimeLoginAlert()
}

    // MARK: - Class
final class CountriesViewModel {
    var countriesData: [Country] = []
    var filteredCountries: [Country] = []
    
    weak var delegate: CountriesViewModelDelegate?
    
    // MARK: - Init ViewModel
    func setUpViewModel() {
        fetchCountries()
    }
    
    private func showFirstTimeLoginAlert() {
        delegate?.showFirstTimeLoginAlert()
    }
    
    func isFirstTimeLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "firstTimeLoggedIn")
    }
    
    func setFirstTimeLoggedIn(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: "firstTimeLoggedIn")
    }
    
    func didSelectRow(index: IndexPath) {
        let selectedCountry = filteredCountries[index.row]
        delegate?.navigateToDetailsVC(selectedCountry: selectedCountry)
    }
    
    func searchCountries(with searchText: String) {
        filteredCountries = searchText.isEmpty ? countriesData : countriesData.filter { country in
            return country.name.common.lowercased().contains(searchText.lowercased())
        }
        delegate?.updateTableView()
    }
    
    // MARK: - Networking
    private func fetchCountries() {
        NetworkService.networkManager.fetchCountries { [weak self] countries, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to fetch countries: \(error)")
                } else if let countries = countries {
                    self?.countriesData = countries
                    self?.filteredCountries = countries
                    self?.delegate?.countriesFetched(countries)
                }
            }
        }
    }
}
