//
//  UserMeAPI.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 14..
//

import Foundation

struct CurrentUser: Codable, Identifiable {
    let id: Int
    let image: String
    let username: String
    let email: String
    let role: String
}

class UserData {
    func downloadData(fromURL: String, bearerToken: String, method: String, completion: @escaping (Result<CurrentUser, Error>) -> Void) {
        guard let url = URL(string: fromURL) else {
            completion(.failure(NetworkError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode) \(url)")
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.badResponse))
                return
            }
            
            do {
                let decodedUserMe = try JSONDecoder().decode(CurrentUser.self, from: data)
                completion(.success(decodedUserMe))
            } catch {
                completion(.failure(NetworkError.failedToDecodeResponse))
            }
        }.resume()
    }
}

class PostViewModel: ObservableObject {
    @Published var currentUser: CurrentUser

    init() {
        self.currentUser = CurrentUser(id: 0, image: "", username: "", email: "", role: "")
        fetchData()
    }
    
    func fetchData() {
        guard let request = NetworkManager.shared.createRequest(.get, path: "Users/me") else {
            return
        }

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decodedUserMe = try JSONDecoder().decode(CurrentUser.self, from: data)
                DispatchQueue.main.async {
                    self?.currentUser = decodedUserMe
                    print("Successfully fetched from users/me")
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        task.resume()
    }
}

