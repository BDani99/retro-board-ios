//
//  Reaction.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 15..
//

import Foundation

struct Reaction: Codable {
    let id: Int?
    let user: ReactionUser?
    let entry: ReactionEntry?
    let reactionType: String?
}

struct ReactionUser: Codable {
    let id: Int?
    let image: String?
    let username: String?
    let email: String?
    let role: String?
}

struct ReactionEntry: Codable {
    let id: Int?
    let entryContent: String?
    let categories: [ReactionCategory]?
    let retrospective: ReactionRetrospective?
    let assignee: ReactionUser?
    let author: ReactionUser?
    let columnType: String?
    let reactionAmount: Int?
    let currentUserReaction: String?
}

struct ReactionCategory: Codable {
    let id: Int?
    let name: String?
    let color: String?
}

struct ReactionRetrospective: Codable {
    let id: Int?
    let name: String?
    let createdAt: String?
    let statsNeeded: Bool?
    let isActive: Bool?
    let entryAmount: ReactionEntryAmount?
}

struct ReactionEntryAmount: Codable {
    let todoColumn: Int?
    let wentWellColumn: Int?
    let needsFixColumn: Int?
    let total: Int?
}

class ReactionViewModel: ObservableObject {
    func createReaction(entryId: Int, reactionType: String, completion: @escaping (Result<Reaction, Error>) -> Void) {
        guard var request = NetworkManager.shared.createRequest(.post, path: "Reactions") else {
            completion(.failure(NetworkError.badUrl))
            return
        }

        let requestBody: [String: Any] = [
            "entryId": entryId,
            "reactionType": reactionType
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
                
                let createdReaction = try decoder.decode(Reaction.self, from: data)
                completion(.success(createdReaction))
            } catch let decodingError {
                print("JSON decoding error: \(decodingError)")
                completion(.failure(decodingError))
            }
        }.resume()
    }
}

