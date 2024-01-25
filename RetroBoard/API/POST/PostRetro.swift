//
//  PostRetro.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 14..
//

import Foundation

struct PostRetrospective: Codable {
    let id: Int?
    let name: String?
    let statsNeeded: Bool?
    let isActive: Bool?
    let entryAmount: Int?
}

class PostRetroViewModel: ObservableObject {
    func createRetrospective(name: String, projectId: Int, statsNeeded: Bool, completion: @escaping (Result<PostRetrospective, Error>) -> Void) {
        guard var request = NetworkManager.shared.createRequest(.post, path: "Retrospectives") else {
            completion(.failure(NetworkError.badUrl))
            return
        }

        let requestBody: [String: Any] = [
            "name": name,
            "projectId": projectId,
            "statsNeeded": statsNeeded
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            completion(.failure(NetworkError.invalidRequest))
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
                decoder.dateDecodingStrategy = .iso8601
                
                let createdRetrospective = try decoder.decode(PostRetrospective.self, from: data)
                completion(.success(createdRetrospective))
            } catch let decodingError {
                print("JSON decoding error: \(decodingError)")
                completion(.failure(decodingError))
            }
        }.resume()
    }
}

