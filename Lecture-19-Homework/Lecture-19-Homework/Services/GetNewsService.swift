//
//  GetNewsService.swift
//  Lecture-19-Homework
//
//  Created by Barbare Tepnadze on 20.04.24.
//

import Foundation

class NetworkService {
    
    func fetchNews(completion: @escaping ([News]?, Error?) -> Void) {
        let urlString = "https://imedinews.ge/api/categorysidebarnews/get"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil, NetworkError.invalidUrl)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
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
                let responseData = try decoder.decode(NewsResponseData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(responseData.newsList, nil)
                }
            } catch {
                print("Decoding error: \(error)")
                completion(nil, NetworkError.decodeError)
            }
        }.resume()
    }
    
}
