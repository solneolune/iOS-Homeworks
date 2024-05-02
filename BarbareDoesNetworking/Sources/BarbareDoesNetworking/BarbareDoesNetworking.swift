import Foundation

public class NetworkService {
    
    public init() {}
    
    public func fetch<T: Codable>(url: URL, parse: @escaping (Data) -> T?, completion: @escaping (Result<T?, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.wrongResponse))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.wrongResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.wrongStatusCode(code: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
            
            let result = parse(data)
            
            if result == nil {
                completion(.failure(.decodeError))
            } else {
                completion(.success(result))
            }
        }.resume()
    }
}
