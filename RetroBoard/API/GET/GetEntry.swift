//
//  GetEntry.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 15..
//

import Foundation

struct Entries: Codable {
    let id: Int
    let name: String
    let color: String
}

class EntryViewModel: ObservableObject {
    func getCategories(for entryId: Int, completion: @escaping (Result<[Entries], Error>) -> Void) {
        guard let request = NetworkManager.shared.createRequest(.get, path: "Entries/\(entryId)/categories") else {
            completion(.failure(NetworkError.badUrl))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.badResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let categories = try decoder.decode([Entries].self, from: data)
                completion(.success(categories))
            } catch let decodingError {
                print("JSON decoding error: \(decodingError)")
                completion(.failure(decodingError))
            }
        }.resume()
    }
}
